 # TP Gestión de Datos – 1° Cuatrimestre 2024
Grupo: LOS_MIGRADORES

 # 🧾Introducción
Este trabajo práctico simula la implementación de un sistema para una cadena de supermercados, permitiendo gestionar ventas, promociones y envíos en sus sucursales físicas.

El sistema requiere migrar los datos existentes a un nuevo modelo lógico y físico, más estructurado y normalizado. Para ello, se rediseña completamente la base de datos y los procesos relacionados, adecuándose a los nuevos requerimientos de la organización.

Además, se implementa un segundo modelo orientado a Business Intelligence (BI), que permite realizar análisis y generar métricas de gestión. Este modelo está pensado para facilitar la toma de decisiones estratégicas basadas en datos.

 # 🛠️ Despliegue
Para su correcta ejecucion, se debe disponer de los datos originales provistos, con el modelo previo conteniendo los datos en una tabla maestra sin ningun tipo de normalizacion.

El siguiente paso es crear un esquema llamado "LOS_MIGRADORES" en SQL Server con la siguiente sentencia:
```sql
CREATE SCHEMA LOS_MIGRADORES;
```

Luego, debe ejecutar los siguientes scripts en el siguiente orden:

- `script_creacion_inicial.sql`

- `script_creacion_BI.sql`

Finalmente, ejecutar los SELECT provistos al final del segundo script para visualizar los resultados del modelo BI.


 # 🎯 Objetivos técnicos alcanzados
- Migración y transformación de datos desde una tabla maestra a un modelo relacional normalizado.

- Aplicación de reglas de negocio para la integración de datos.

- Diseño de esquema para Business Intelligence con vistas analíticas.

- Ejecución de sentencias SQL complejas para manipulación y consulta de datos.
