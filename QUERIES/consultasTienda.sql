SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, precio, precio * 1.06 FROM producto;
SELECT nombre AS "nom de producte", precio AS "euros", precio * 1.06 AS "dòlars nord-americans" FROM producto;
SELECT  UPPER(nombre), precio FROM producto;
SELECT LOWER(nombre), precio FROM producto;
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante;
SELECT nombre, ROUND(precio) FROM producto;
SELECT nombre, TRUNCATE(precio, 0) FROM producto;
SELECT fabricante.codigo FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
SELECT DISTINCT fabricante.codigo FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo;
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre;
SELECT producto.nombre, precio, fabricante.nombre FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo;

 
