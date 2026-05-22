CREATE DATABASE IF NOT EXISTS catalogo_laley
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE catalogo_laley;

DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;


CREATE TABLE categorias (
  id        INT         NOT NULL AUTO_INCREMENT,
  nombre    VARCHAR(50) NOT NULL,
  slug      VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE productos (
  id               INT            NOT NULL AUTO_INCREMENT,
  nombre           VARCHAR(150)   NOT NULL,
  marca            VARCHAR(80)    NOT NULL,
  categoria_id     INT            NOT NULL,
  descripcion      TEXT           NOT NULL,
  precio           DECIMAL(10,2)  NOT NULL,
  precio_antes     DECIMAL(10,2)  DEFAULT NULL,
  emoji            VARCHAR(10)    NOT NULL DEFAULT '🖥️',
  badge            VARCHAR(20)    DEFAULT NULL,
  especificaciones TEXT           DEFAULT NULL,
  activo           TINYINT(1)     NOT NULL DEFAULT 1,
  fecha_registro   TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);


INSERT INTO categorias (nombre, slug) VALUES
  ('Laptops',     'laptop'),
  ('PC',          'pc'),
  ('Impresoras',  'impresora'),
  ('Perifericos', 'periférico');


INSERT INTO productos (nombre, marca, categoria_id, descripcion, precio, precio_antes, emoji, badge, especificaciones) VALUES
('Laptop HP Victus 15','HP',1,'Ideal para estudiantes y gamers. Pantalla Full HD de 15.6 pulgadas con procesador de ultima generacion.',899.00,NULL,'💻','nuevo','[{"l":"Procesador","v":"AMD Ryzen 5 5600H"},{"l":"RAM","v":"8 GB DDR4"},{"l":"Almacenamiento","v":"512 GB SSD"},{"l":"Pantalla","v":"15.6 Full HD"},{"l":"GPU","v":"NVIDIA GTX 1650"},{"l":"Sistema","v":"Windows 11"}]'),
('MacBook Air M2','Apple',1,'Ultraligera, silenciosa y con bateria para todo el dia. Perfecta para diseno, edicion y trabajo creativo.',1199.00,1399.00,'💻','oferta','[{"l":"Chip","v":"Apple M2"},{"l":"RAM","v":"8 GB Unificada"},{"l":"Almacenamiento","v":"256 GB SSD"},{"l":"Pantalla","v":"13.6 Liquid Retina"},{"l":"Bateria","v":"Hasta 18 horas"},{"l":"Sistema","v":"macOS Ventura"}]'),
('Lenovo IdeaPad 3','Lenovo',1,'Laptop confiable para el dia a dia. Perfecta para tareas escolares, navegacion y documentos de oficina.',449.00,NULL,'💻',NULL,'[{"l":"Procesador","v":"Intel Core i3-1215U"},{"l":"RAM","v":"8 GB DDR4"},{"l":"Almacenamiento","v":"256 GB SSD"},{"l":"Pantalla","v":"15.6 HD"},{"l":"Bateria","v":"Hasta 7 horas"},{"l":"Sistema","v":"Windows 11 Home"}]'),
('ASUS VivoBook 15','ASUS',1,'Diseno delgado y liviano, teclado retroiluminado y pantalla NanoEdge. Gran relacion calidad-precio.',599.00,NULL,'💻',NULL,'[{"l":"Procesador","v":"Intel Core i5-1235U"},{"l":"RAM","v":"16 GB DDR4"},{"l":"Almacenamiento","v":"512 GB SSD"},{"l":"Pantalla","v":"15.6 FHD"},{"l":"GPU","v":"Intel Iris Xe"},{"l":"Sistema","v":"Windows 11"}]');


INSERT INTO productos (nombre, marca, categoria_id, descripcion, precio, precio_antes, emoji, badge, especificaciones) VALUES
('PC Gamer Ryzen 7','La Ley Custom',2,'Torre ensamblada de alto rendimiento para gaming y edicion de video. Incluye gabinete con luces RGB.',1350.00,NULL,'🖥️','nuevo','[{"l":"Procesador","v":"AMD Ryzen 7 5700X"},{"l":"RAM","v":"16 GB DDR4 3200"},{"l":"Almacenamiento","v":"1 TB NVMe SSD"},{"l":"GPU","v":"RX 6650 XT 8GB"},{"l":"Fuente","v":"650W 80+ Bronze"},{"l":"Luces","v":"RGB Completo"}]'),
('PC Oficina Intel i5','La Ley Custom',2,'Computadora de escritorio perfecta para uso en oficina, tareas administrativas y educacion virtual.',520.00,NULL,'🖥️',NULL,'[{"l":"Procesador","v":"Intel Core i5-12400"},{"l":"RAM","v":"8 GB DDR4"},{"l":"Almacenamiento","v":"500 GB SSD"},{"l":"GPU","v":"Intel UHD 730"},{"l":"Fuente","v":"400W"},{"l":"Sistema","v":"Windows 11 Pro"}]'),
('All-in-One HP 24','HP',2,'Todo en uno elegante. El computador y el monitor en un solo equipo, sin cables enredados en tu escritorio.',780.00,950.00,'🖥️','oferta','[{"l":"Procesador","v":"Intel Core i5-1135G7"},{"l":"RAM","v":"8 GB DDR4"},{"l":"Almacenamiento","v":"512 GB SSD"},{"l":"Pantalla","v":"23.8 FHD IPS"},{"l":"Camara","v":"HD Integrada"},{"l":"Sistema","v":"Windows 11"}]'),
('Mini PC Intel NUC','Intel',2,'El poder de un PC de escritorio en un formato ultracompacto. Perfecto para oficina, aulas y digital signage.',399.00,480.00,'🖥️','oferta','[{"l":"Procesador","v":"Intel Core i3-1115G4"},{"l":"RAM","v":"8 GB DDR4"},{"l":"Almacenamiento","v":"256 GB SSD"},{"l":"Graficos","v":"Intel UHD"},{"l":"Puertos","v":"HDMI + USB-C + 4xUSB"},{"l":"Dimensiones","v":"11.7 x 11.2 x 3.6 cm"}]');


INSERT INTO productos (nombre, marca, categoria_id, descripcion, precio, precio_antes, emoji, badge, especificaciones) VALUES
('Impresora HP DeskJet 2775','HP',3,'Impresora multifuncional con WiFi. Imprime, escanea y copia en color. Perfecta para el hogar y la escuela.',89.00,NULL,'🖨️',NULL,'[{"l":"Tipo","v":"Inyeccion de tinta"},{"l":"Funciones","v":"Imprime, Escanea, Copia"},{"l":"Conectividad","v":"WiFi + USB"},{"l":"Velocidad","v":"7.5 ppm Color"},{"l":"Tinta","v":"HP 682"},{"l":"Sistema","v":"Win / Mac"}]'),
('Impresora Epson L3250','Epson',3,'Sistema de tinta continua EcoTank. Ahorra en tintas y produce miles de paginas a bajo costo.',195.00,230.00,'🖨️','oferta','[{"l":"Tipo","v":"Tinta continua EcoTank"},{"l":"Funciones","v":"Imprime, Escanea, Copia"},{"l":"Conectividad","v":"WiFi + USB"},{"l":"Rendimiento","v":"4500 pag B/N"},{"l":"Resolucion","v":"5760 x 1440 dpi"},{"l":"Sistema","v":"Win / Mac / Android"}]'),
('Impresora Laser HP M15w','HP',3,'Impresora laser monocromatica compacta e inalambrica. Ideal para documentos rapidos y de alta calidad.',149.00,NULL,'🖨️',NULL,'[{"l":"Tipo","v":"Laser monocromatica"},{"l":"Velocidad","v":"19 ppm"},{"l":"Conectividad","v":"WiFi + USB"},{"l":"Resolucion","v":"600 x 600 dpi"},{"l":"Toner","v":"HP CF248A"},{"l":"Peso","v":"4.1 kg"}]');

INSERT INTO productos (nombre, marca, categoria_id, descripcion, precio, precio_antes, emoji, badge, especificaciones) VALUES
('Mouse Logitech MX Master 3','Logitech',4,'El mouse mas avanzado para productividad. Scroll electromagnetico y conexion inalambrica de precision.',99.00,NULL,'🖱️','nuevo','[{"l":"Conexion","v":"Bluetooth + USB"},{"l":"DPI","v":"Hasta 4000 DPI"},{"l":"Botones","v":"7 programables"},{"l":"Bateria","v":"70 dias recarga"},{"l":"Compatib.","v":"Win / Mac / Linux"},{"l":"Color","v":"Grafito / Azul"}]'),
('Teclado Mecanico Redragon K552','Redragon',4,'Teclado mecanico gaming con switches Red, retroiluminacion RGB y construccion metalica resistente.',55.00,NULL,'⌨️',NULL,'[{"l":"Tipo","v":"Mecanico TKL"},{"l":"Switches","v":"Red (Lineal)"},{"l":"Iluminacion","v":"RGB 18 modos"},{"l":"Conexion","v":"USB"},{"l":"Teclas","v":"87"},{"l":"Material","v":"Aluminio + ABS"}]'),
('Audifonos HyperX Cloud Stinger','HyperX',4,'Auriculares gaming livianos con sonido estereo virtual 7.1 y microfono abatible con cancelacion de ruido.',59.00,NULL,'🎧',NULL,'[{"l":"Conexion","v":"3.5mm / USB"},{"l":"Drivers","v":"50mm con neodimio"},{"l":"Microfono","v":"Abatible, cancelacion de ruido"},{"l":"Respuesta","v":"10-23000 Hz"},{"l":"Peso","v":"275 g"},{"l":"Compatible","v":"PC, PS4, Xbox, Switch"}]'),
('Monitor Samsung 24 FHD','Samsung',4,'Monitor IPS de 24 pulgadas Full HD con tiempo de respuesta de 5ms y panel de colores vibrantes.',179.00,210.00,'🖥️','oferta','[{"l":"Tamano","v":"24 Full HD"},{"l":"Panel","v":"IPS"},{"l":"Respuesta","v":"5ms"},{"l":"Refresh","v":"75 Hz"},{"l":"Puertos","v":"HDMI + VGA"},{"l":"VESA","v":"75x75mm"}]'),
('Webcam Logitech C920','Logitech',4,'Camara web Full HD 1080p ideal para videollamadas, clases en linea y streaming con imagen clara.',79.00,NULL,'📷','nuevo','[{"l":"Resolucion","v":"1080p / 30fps"},{"l":"Microfono","v":"Estereo reduccion de ruido"},{"l":"Enfoque","v":"Automatico"},{"l":"Conexion","v":"USB"},{"l":"Compatible","v":"Win / Mac / Chrome OS"},{"l":"Campo","v":"78 grados"}]'),
('Disco Duro Externo WD 1TB','Western Digital',4,'Almacenamiento portatil ultra-compacto. Guarda tus archivos, fotos, videos y respaldo del sistema.',65.00,NULL,'💾',NULL,'[{"l":"Capacidad","v":"1 TB"},{"l":"Interfaz","v":"USB 3.0"},{"l":"Velocidad","v":"Hasta 130 MB/s"},{"l":"Formato","v":"2.5 Portatil"},{"l":"Compatible","v":"Win / Mac / Chromebook"},{"l":"Garantia","v":"3 anos"}]'),
('Router TP-Link AX3000','TP-Link',4,'Router WiFi 6 de doble banda con cobertura para toda la casa y velocidades de hasta 3000 Mbps.',85.00,NULL,'📡',NULL,'[{"l":"Estandar","v":"WiFi 6 (802.11ax)"},{"l":"Velocidad","v":"Hasta 3000 Mbps"},{"l":"Bandas","v":"2.4GHz + 5GHz"},{"l":"Antenas","v":"4 omnidireccionales"},{"l":"Puertos","v":"4x Gigabit LAN + 1 WAN"},{"l":"Seguridad","v":"WPA3"}]');