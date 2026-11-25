page 50159 "ATT Attendance Card"
{
    Caption = 'Attendance Entry';
    PageType = Card;
    SourceTable = "ATT Attendance Entry";
    ApplicationArea = All;
    DataCaptionFields = "Employee No.", "Employee Name";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee this entry is for.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the employee.';
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the attendance entry.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the employee was present, working from home, on leave or absent.';
                }
            }
            group(Times)
            {
                Caption = 'Times';
                Visible = (Rec.Status = Rec.Status::Present) or (Rec.Status = Rec.Status::"Work From Home");

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
            }
            group(RemoteWork)
            {
                Caption = 'Remote Work';
                Visible = Rec.Status = Rec.Status::"Work From Home";

                field("Work Plan"; Rec."Work Plan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what the employee is working on while working from home.';
                    MultiLine = true;
                }
            }
            group(Apology)
            {
                Caption = 'Apology';
                Visible = Rec.Status = Rec.Status::"Absent With Apology";

                field("Apology Reason"; Rec."Apology Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason given in the apology.';
                    ShowMandatory = true;
                    MultiLine = true;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec.Status = Rec.Status::"Absent With Apology") and (Rec."Apology Reason" = '') then
            Error('Enter the apology reason before closing this entry.');
    end;
}