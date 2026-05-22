<?php
session_start();

// Solo admins pueden guardar productos
if (!isset($_SESSION['usuario_id']) || $_SESSION['rol'] !== 'admin') {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode([
        'ok'  => false, 
        'msg' => 'Acceso denegado. Solo administradores pueden agregar productos.'
    ]);
    exit;
}
header('Content-Type: application/json; charset=utf-8');
require_once 'conexion.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['ok' => false, 'msg' => 'Metodo no permitido']);
    exit;
}

// ── PASO 1: Leer datos del formulario ──────────────
$data        = json_decode(file_get_contents('php://input'), true);
$nombre      = trim($data['nombre']      ?? '');
$marca       = trim($data['marca']       ?? '');
$categoria   = trim($data['categoria']   ?? '');
$descripcion = trim($data['descripcion'] ?? '');
$precio      = floatval($data['precio']  ?? 0);
$precioAntes = (!empty($data['precio_antes']) && floatval($data['precio_antes']) > 0)
               ? floatval($data['precio_antes']) : null;
$emoji       = trim($data['emoji']       ?? 'U+1F5A5');
$badge       = trim($data['badge']       ?? '');
$specs       = $data['specs']            ?? [];

// ── PASO 2: Validar campos obligatorios ────────────
if (empty($nombre))      { echo json_encode(['ok'=>false,'msg'=>'El nombre es obligatorio.']); exit; }
if (empty($marca))       { echo json_encode(['ok'=>false,'msg'=>'La marca es obligatoria.']); exit; }
if (empty($categoria))   { echo json_encode(['ok'=>false,'msg'=>'Selecciona una categoria.']); exit; }
if (empty($descripcion)) { echo json_encode(['ok'=>false,'msg'=>'La descripcion es obligatoria.']); exit; }
if ($precio <= 0)        { echo json_encode(['ok'=>false,'msg'=>'El precio debe ser mayor a 0.']); exit; }

// ── PASO 3: Buscar id de la categoría en la BD ─────
// Consulta: SELECT id FROM categorias WHERE slug = "laptop"
$stmtCat = $conexion->prepare("SELECT id FROM categorias WHERE slug = ?");
$stmtCat->bind_param("s", $categoria);
$stmtCat->execute();
$resCat = $stmtCat->get_result()->fetch_assoc();
$stmtCat->close();

if (!$resCat) {
    echo json_encode(['ok'=>false,'msg'=>'Categoria no valida: ' . $categoria]);
    exit;
}
$categoriaId = (int)$resCat['id'];

// ── PASO 4: Convertir specs a texto JSON ───────────
// Las specs llegan como: [{"l":"RAM","v":"8 GB"}, ...]
// Se guardan en la columna "especificaciones" como texto
$specsLimpias = [];
if (is_array($specs)) {
    foreach ($specs as $s) {
        if (!empty($s['l']) && !empty($s['v'])) {
            $specsLimpias[] = ['l' => trim($s['l']), 'v' => trim($s['v'])];
        }
    }
}
$specsJson = json_encode($specsLimpias, JSON_UNESCAPED_UNICODE);
$badgeVal  = !empty($badge) ? $badge : null;

// ── PASO 5: INSERT INTO productos ─────────────────
// Este INSERT solo agrega una fila nueva.
// Los productos existentes NO se tocan.
$sql = "INSERT INTO productos
            (nombre, marca, categoria_id, descripcion,
             precio, precio_antes, emoji, badge, especificaciones, activo)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";

$stmt = $conexion->prepare($sql);
$stmt->bind_param(
    "ssisdssss",   // s=string i=int d=decimal
    $nombre,       // VARCHAR nombre del producto
    $marca,        // VARCHAR marca
    $categoriaId,  // INT     id de la categoría
    $descripcion,  // TEXT    descripción
    $precio,       // DECIMAL precio actual
    $precioAntes,  // DECIMAL precio anterior (NULL si no hay)
    $emoji,        // VARCHAR emoji del producto
    $badgeVal,     // VARCHAR "nuevo","oferta" o NULL
    $specsJson     // TEXT    especificaciones en JSON
);

if (!$stmt->execute()) {
    $error = $conexion->error;
    $stmt->close();
    $conexion->close();
    echo json_encode(['ok'=>false,'msg'=>'Error al guardar en BD: ' . $error]);
    exit;
}

$nuevoId = $stmt->insert_id;  // ID del producto recién creado
$stmt->close();
$conexion->close();

// ── PASO 6: Responder al navegador ────────────────
echo json_encode([
    'ok'  => true,
    'id'  => $nuevoId,
    'msg' => 'Producto "' . $nombre . '" guardado correctamente con ID #' . $nuevoId
]);