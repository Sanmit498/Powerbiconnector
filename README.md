Step-by-Step Guide to Create a Power BI Custom Connector with DirectQuery using ODBC
1. Setting Up Your Development Environment
Install Power Query SDK:

Install the Power Query SDK extension in Visual Studio Code. This extension provides tools to create, build, and debug custom data connectors for Power BI.
Install the Power BI Desktop:

Ensure you have the latest version of Power BI Desktop installed. You can download it from the Power BI website.
2. Create the Custom Connector
Create a New Connector Project:

Open Visual Studio Code.
Create a new folder for your project, e.g., PowerBIODBCConnector.
Open the folder in VS Code.
Use the Power Query SDK to create a new connector project by opening the command palette (Ctrl+Shift+P or Cmd+Shift+P on macOS) and selecting Power Query SDK: Create New Project.
Edit the Connector Code:

Replace the content of the main .pq file (e.g., ConnectorName.pq) with the following code, ensuring it includes the necessary settings to support DirectQuery:
m
Copy code
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
        ])
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
        Parameters = [
            [
                Name = "dsn",
                Label = "DSN",
                Description = "Data Source Name (DSN)",
                Type = type text
            ]
        ]
    ]
];
3. Build and Test the Connector
Build the Connector:

Use the Power Query SDK tools in Visual Studio Code to build your project. Open the command palette (Ctrl+Shift+P or Cmd+Shift+P on macOS) and select Power Query SDK: Build Project. This will generate a .mez file for your connector.
Deploy the Connector:

Copy the generated .mez file to the [Documents]\Power BI Desktop\Custom Connectors directory.
Clear Cache in Power BI Desktop:

Open Power BI Desktop.
Go to File -> Options and settings -> Options -> Data Load.
Click on Clear cache.
Enable Custom Connectors:

Go to File -> Options and settings -> Options -> Security.
Ensure Allow any extension to load without validation or warning is selected.
Restart Power BI Desktop:

After making these changes, restart Power BI Desktop.
4. Use the Connector in Power BI
Get Data:

Open Power BI Desktop.
Go to the Home tab.
Click on Get Data.
Select More... to see all available connectors.
Find and select your custom connector (e.g., "PostgreSQL ODBC").
Enter DSN:

When prompted, enter your DSN (e.g., "JIST 2").
Click OK.
Choose DirectQuery or Import Mode:

After entering the DSN, you should see an option to choose between Import and DirectQuery.
Select DirectQuery.
Navigate and Load Data:

You can now navigate through the data and load it into Power BI using DirectQuery.
5. Verify DirectQuery Mode
Check Storage Mode:
After loading the data, go to Modeling -> Manage Relationships.
Select a table to check its storage mode.
Ensure it shows as DirectQuery.
Key Points and Fixes for Common Errors
Error: No Option to Choose DirectQuery:

Cause: SupportsDirectQuery was not recognized properly.
Fix: Ensure SupportsDirectQuery = true is set in both the DataSource.Kind and Publish sections.
Error: Remote Repository Not Found (if using GitHub):

Cause: Incorrect repository URL or repository not existing on GitHub.
Fix: Verify and correct the repository URL and ensure the repository is created on GitHub.
By following these steps, you can create a custom Power BI connector that supports DirectQuery using ODBC. This guide covers the entire process from setting up your development environment to deploying and using the connector in Power BI. If you encounter any issues or need further assistance, feel free to ask!
