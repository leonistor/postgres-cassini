# "A Curious Moon" book code

## Tricks

### show tables in `public` and `import` schemas

`\dt (public|import).*`

### tables and rowcount [source](https://dataedo.com/kb/query/postgresql/list-of-tables-by-the-number-of-rows)
```sql
select n.nspname as table_schema,
        c.relname as table_name,
        c.reltuples::int as rows
from pg_class c
join pg_namespace n on n.oid = c.relnamespace
where c.relkind = 'r'
   and n.nspname not in ('information_schema','pg_catalog')
order by table_name;
```

## Utils

### Restore database, only structure

https://www.endpoint.com/blog/2010/05/12/postgresql-template-databases-to

### CSVKit

https://github.com/wireservice/csvkit

Generate import table structure, with TEXT instead of VARCHAR:

```sh
csvsql 200504800_L1A_05.CSV -i postgresql --tables import.inms --no-constraints | \
                  sed 's/VARCHAR/TEXT/g' > import_inms.sql
```

Manually remove `"` surrounding tables from script...

### xsv

https://github.com/BurntSushi/xsv

### Vim: save without formatting

No auto command and write: `:noa w`

### SQL Formatters

- Postgres: http://sqlformat.darold.net/

- Queries: https://sqlformat.org/

