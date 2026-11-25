page 50160 "ATT Remote Work List"
{
    Caption = 'Remote Entries';
    PageType = List;
    SourceTable = "ATT Attendance Entry";
    SourceTableView = where(Status = const("Work From Home"));
    CardPageId = "ATT Attendance Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee working from home.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the employee.';
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the remote work entry.';
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time the employee started work.';
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time the employee finished work.';
                }
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hours between Time In and Time Out.';
                }
                field(Late; Rec.Late)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the employee started after the start time.';
                }
                field("Work Plan"; Rec."Work Plan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what the employee is working on.';
                }
            }
        }
    }
}