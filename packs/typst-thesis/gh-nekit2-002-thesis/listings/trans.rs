pub struct TableAmArgs;
unsafe impl SqlTranslatable for TableAmArgs {
    fn type_name() -> &'static str {
        "internal"
    }

    fn argument_sql() -> Result<SqlMapping, ArgumentError> {
        Ok(SqlMapping::literal("internal"))
    }

    fn return_sql() -> Result<Returns, ReturnsError> {
        Ok(Returns::One(SqlMapping::literal("internal")))
    }
}

pub struct TableAmHandler(pub &'static TableAmRoutine);