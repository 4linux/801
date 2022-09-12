SELECT
    setting,  -- Valor
    context,  -- Contexto
    vartype,  -- Tipo de dado
    unit      -- Unidade
    FROM pg_settings
    WHERE name = 'shared_buffers';

SHOW application_name;

SET application_name = 'curso_adm_postgres';

SELECT
    setting, context, vartype, unit
    FROM pg_settings
    WHERE name = 'application_name';
