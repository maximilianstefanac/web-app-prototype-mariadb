CREATE DATABASE webgis CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE webgis.tree (
    tree_id INT PRIMARY KEY,
    species VARCHAR(100),
    position POINT NOT NULL
);

-- POINT(x y) -> latitude = x, longitude = y
INSERT INTO webgis.tree VALUES
    (1, NULL, PointFromText('POINT(8.677202 49.218523)')),
    (2, NULL, PointFromText('POINT(8.677193 49.218400)')),
    (3, NULL, PointFromText('POINT(8.677184 49.218310)')),
    (4, NULL, PointFromText('POINT(8.677112 49.217826)')),
    (5, NULL, PointFromText('POINT(8.677103 49.217069)')),
    (6, NULL, PointFromText('POINT(8.676717 49.216577)'));

CREATE TABLE webgis.plot (
    plot_id INT PRIMARY KEY,
    plot_name VARCHAR(100),
    boundary POLYGON NOT NULL 
);

-- Last Point in Polygon must be the first one - other than in leaflet
INSERT INTO webgis.plot VALUES
    (1, 'Obst-Gen-Garten', PolygonFromText('POLYGON((8.677058 49.218531,8.676849 49.216258,8.674748 49.216280,8.674712 49.216217,8.676846 49.216199,8.676861 49.216100,8.677283 49.216188,8.677462 49.218530, 8.677058 49.218531))'));

-- select tree which position is in the polygon of the Obst-Gen-Garten -> trees with id 1 - 5
SELECT * FROM webgis.tree as t WHERE within(t.`position`, (SELECT boundary FROM webgis.plot WHERE plot_id = 1 LIMIT 1));


-- transform geo data-type to GeoJSON in SELECT Statement
SELECT ST_AsGeoJSON(position, 6) FROM webgis.tree;