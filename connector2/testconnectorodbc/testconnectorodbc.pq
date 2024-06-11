[Version = "1.0.0"]
section testconnectorodbc;

// Define the icons for the connector
shared testconnectorodbcIcons = [
    Icon16 = { Extension.Contents("testconnectorodbc16.png"), Extension.Contents("testconnectorodbc16.png") },
    Icon32 = { Extension.Contents("testconnectorodbc32.png"), Extension.Contents("testconnectorodbc32.png") }
];

[DataSource.Kind="testconnectorodbc", Publish="testconnectorodbc.Publish"]
shared testconnectorodbc.Contents = (dsn as text) =>
    let
        connectionString = "dsn=" & dsn & ";",
        NavigationTable = Odbc.DataSource(connectionString, [
            HierarchicalNavigation = true
        ]),
        SqlCapabilities = [ SupportsDirectQuery = true]
    in
        NavigationTable;

testconnectorodbc = [
    TestConnection = (dataSourcePath) => {"testconnectorodbc.Contents", dataSourcePath},
    Authentication = [
        Anonymous = []
    ],
    SupportsDirectQuery = true
];

testconnectorodbc.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = testconnectorodbcIcons,
    SupportsDirectQuery = true,
    SourceTypeImage = testconnectorodbcIcons,
    Source = [
        Name = "testconnectorodbc.Contents",
        Label = "PostgreSQL ODBC",
        Hidden = false,
        Parameters = {
            [
                Name = "dsn",
                Label = "DSN",
                Description = "Data Source Name (DSN)",
                Type = type text
            ]
        }
    ]
];
