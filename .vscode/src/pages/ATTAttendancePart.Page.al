page 50152 "ATT Attendance Part"
{
    Caption = 'Recent Attendance';
    PageType = ListPart;
    SourceTable = "ATT Attendance Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.") { ApplicationArea = All; }
                field("Attendance Date"; Rec."Attendance Date") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Time In"; Rec."Time In") { ApplicationArea = All; }
                field("Time Out"; Rec."Time Out") { ApplicationArea = All; }
            }
        }
    }
}