table 50150 "ATT Attendance Entry"
{
    Caption = 'Attendance Entry';
    DataClassification = CustomerContent;
    LookupPageId = "ATT Attendance List";
    DrillDownPageId = "ATT Attendance List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                UpdateCalculatedFields();
            end;
        }
        field(3; "Attendance Date"; Date)
        {
            Caption = 'Attendance Date';
        }
        field(4; "Time In"; Time)
        {
            Caption = 'Time In';

            trigger OnValidate()
            begin
                CheckTimes();
                UpdateCalculatedFields();
            end;
        }
        field(5; "Time Out"; Time)
        {
            Caption = 'Time Out';

            trigger OnValidate()
            begin
                CheckTimes();
                UpdateCalculatedFields();
            end;
        }
        field(6; Status; Enum "ATT Attendance Status")
        {
            Caption = 'Status';

            trigger OnValidate()
            begin
                if not (Status in [Status::Present, Status::"Work From Home"]) then begin
                    "Time In" := 0T;
                    "Time Out" := 0T;
                end;
                if Status <> Status::"Absent With Apology" then
                    "Apology Reason" := '';
                if Status <> Status::"Work From Home" then
                    "Work Plan" := '';
                UpdateCalculatedFields();
            end;
        }
        field(7; "Apology Reason"; Text[250])
        {
            Caption = 'Apology Reason';
        }
        field(8; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(9; "Hours Worked"; Decimal)
        {
            Caption = 'Hours Worked';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(10; Late; Boolean)
        {
            Caption = 'Late';
            Editable = false;
        }
        field(11; "Work Plan"; Text[250])
        {
            Caption = 'Work Plan';
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(Employee; "Employee No.", "Attendance Date") { }
    }

    trigger OnInsert()
    begin
        if "Attendance Date" = 0D then
            "Attendance Date" := Today;
        UpdateCalculatedFields();
        CheckDuplicate();
    end;

    trigger OnModify()
    begin
        UpdateCalculatedFields();
        CheckDuplicate();
    end;

    local procedure CheckDuplicate()
    var
        Other: Record "ATT Attendance Entry";
    begin
        if "Employee No." = '' then
            exit;
        Other.SetRange("Employee No.", "Employee No.");
        Other.SetRange("Attendance Date", "Attendance Date");
        Other.SetFilter("Entry No.", '<>%1', "Entry No.");
        if not Other.IsEmpty() then
            Error('Employee %1 already has an attendance entry for %2.', "Employee No.", "Attendance Date");
    end;

    local procedure CheckTimes()
    begin
        if ("Time In" <> 0T) and ("Time Out" <> 0T) then
            if "Time Out" <= "Time In" then
                Error('Time Out must be later than Time In.');
    end;

    local procedure UpdateCalculatedFields()
    var
        EmployeeRec: Record Employee;
        Elapsed: Duration;
    begin
        if EmployeeRec.Get("Employee No.") then
            "Employee Name" := CopyStr(EmployeeRec.FullName(), 1, MaxStrLen("Employee Name"))
        else
            "Employee Name" := '';

        "Hours Worked" := 0;
        if ("Time In" <> 0T) and ("Time Out" > "Time In") then begin
            Elapsed := "Time Out" - "Time In";
            "Hours Worked" := Round(Elapsed / 3600000, 0.01);
        end;

        Late := (Status in [Status::Present, Status::"Work From Home"]) and ("Time In" <> 0T) and ("Time In" > GetStartTime());
    end;

    local procedure GetStartTime(): Time
    begin
        exit(080000T);
    end;
}