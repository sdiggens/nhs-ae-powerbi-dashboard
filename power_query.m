let
    Source = Folder.Files("C:\Users\samdi\OneDrive\Desktop\NHS_AE"),
    #"Filtered Hidden Files1" = Table.SelectRows(Source, each [Attributes]?[Hidden]? <> true),
    #"Invoke Custom Function1" = Table.AddColumn(#"Filtered Hidden Files1", "Transform File", each #"Transform File"([Content])),
    #"Renamed Columns1" = Table.RenameColumns(#"Invoke Custom Function1", {"Name", "Source.Name"}),
    #"Removed Other Columns1" = Table.SelectColumns(#"Renamed Columns1", {"Source.Name", "Transform File"}),
    #"Expanded Table Column1" = Table.ExpandTableColumn(#"Removed Other Columns1", "Transform File", Table.ColumnNames(#"Transform File"(#"Sample File"))),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded Table Column1",{{"Source.Name", type text}, {"Period", type text}, {"Org Code", type text}, {"Parent Org", type text}, {"Org name", type text}, {"A&E attendances Type 1", Int64.Type}, {"A&E attendances Type 2", Int64.Type}, {"A&E attendances Other A&E Department", Int64.Type}, {"A&E attendances Booked Appointments Type 1", Int64.Type}, {"A&E attendances Booked Appointments Type 2", Int64.Type}, {"A&E attendances Booked Appointments Other Department", Int64.Type}, {"Attendances over 4hrs Type 1", Int64.Type}, {"Attendances over 4hrs Type 2", Int64.Type}, {"Attendances over 4hrs Other Department", Int64.Type}, {"Attendances over 4hrs Booked Appointments Type 1", Int64.Type}, {"Attendances over 4hrs Booked Appointments Type 2", Int64.Type}, {"Attendances over 4hrs Booked Appointments Other Department", Int64.Type}, {"Patients who have waited 4-12 hs from DTA to admission", Int64.Type}, {"Patients who have waited 12+ hrs from DTA to admission", Int64.Type}, {"Emergency admissions via A&E - Type 1", Int64.Type}, {"Emergency admissions via A&E - Type 2", Int64.Type}, {"Emergency admissions via A&E - Other A&E department", Int64.Type}, {"Other emergency admissions", Int64.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each true),
    #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows",{"Period", "Org Code", "Parent Org", "Org name", "A&E attendances Type 1", "Attendances over 4hrs Type 1", "Patients who have waited 12+ hrs from DTA to admission"}),
    #"Filtered Rows1" = Table.SelectRows(#"Removed Other Columns", each [#"A&E attendances Type 1"] > 0),
    #"Filtered Rows2" = Table.SelectRows(#"Filtered Rows1", each ([Org name] <> "TOTAL")),
    #"Renamed Columns" = Table.RenameColumns(#"Filtered Rows2",{{"Org Code", "Trust Code"}, {"Parent Org", "Region"}, {"Org name", "Trust"}, {"A&E attendances Type 1", "Attendances"}, {"Attendances over 4hrs Type 1", "Over 4 Hours"}, {"Patients who have waited 12+ hrs from DTA to admission", "Over 12 Hours"}}),
    #"Removed Other Columns2" = Table.SelectColumns(#"Renamed Columns",{"Period", "Trust Code", "Region", "Trust", "Attendances", "Over 4 Hours", "Over 12 Hours"}),
    #"Added Custom" = Table.AddColumn(#"Removed Other Columns2", "Month", each Date.FromText("1 " & Text.Replace(Text.AfterDelimiter([Period], "-"), "-", " "))),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Custom",{{"Month", type date}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type1",{"Period"})
in
    #"Removed Columns"
