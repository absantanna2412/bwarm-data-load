# PostgreSQL
Load Scripts to PostgreSQL from locally stored files, if you need server stored files udate the scripts changing \copy by COPY.

_Bulk insert using \copy (for client-side execution) or COPY (for server-side execution)_

PostgreSQL is case-sensitive for table names and field names. By default, PostgreSQL converts unquoted identifiers (including table and column names) to lowercase. This means that if you create a table or a column with uppercase letters without quoting them, PostgreSQL will store them in lowercase.

Lowercase names with underscores as separators (snake_case) are a common convention in PostgreSQL. This convention enhances readability and consistency in your database schema, making it easier for developers and database administrators to understand and maintain the database
