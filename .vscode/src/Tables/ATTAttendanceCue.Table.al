table 50155 "ATT Attendance Cue"
{
    Caption = 'Attendance Cue';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Present Today"; Integer)
        {
            Caption = 'Present Today';
            FieldClass = FlowField;
            CalcFormula = count("ATT Attendance Entry" where("Attendance Date" = field("Date Filter"), Status = const(Present)));
            Editable = false;
        }
        field(3; "Absent With Apology"; Integer)
        {
            Caption = 'Absent With Apology';
            FieldClass = FlowField;
            CalcFormula = count("ATT Attendance Entry" where("Attendance Date" = field("Date Filter"), Status = const("Absent With Apology")));
            Editable = false;
        }
        field(4; "Absent Without Apology"; Integer)
        {
            Caption = 'Absent Without Apology';
            FieldClass = FlowField;
            CalcFormula = count("ATT Attendance Entry" where("Attendance Date" = field("Date Filter"), Status = const("Absent Without Apology")));
            Editable = false;
        }
        field(5; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(6; "Working From Home"; Integer)
        {
            Caption = 'Working From Home';
            FieldClass = FlowField;
            CalcFormula = count("ATT Attendance Entry" where("Attendance Date" = field("Date Filter"), Status = const("Work From Home")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}