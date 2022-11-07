local SETTINGS = {
    sqls = {
        connections = {
          {
            driver = 'mysql',
            dataSourceName = "Server=localhost;Database=employees;User Id=adi;Password=singh;",
          },
          {
            driver = 'postgresql',
            dataSourceName = 'host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable',
          },
        },
      },
}

return SETTINGS
