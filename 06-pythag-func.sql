DROP FUNCTION IF EXISTS pythag (numeric, numeric, numeric);

CREATE FUNCTION pythag (
    x numeric,
    y numeric,
    z numeric,
    out numeric
)
AS $$
    select sqrt(
        (x * x) +
        (y * y) +
        (z * z)
    )::numeric(10, 2);
$$
LANGUAGE sql;
