page 50161 "ATT WFH Request"
{
    Caption = 'Work From Home Request';
    PageType = Card;
    SourceTable = "ATT Attendance Entry";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Request';

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee who will work from home.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the employee.';
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the day the employee will work from home.';
                }
                field("Work Plan"; Rec."Work Plan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what the employee will work on.';
                    MultiLine = true;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status := Rec.Status::"Work From Home";
        Rec."Attendance Date" := Today;
    end;
}