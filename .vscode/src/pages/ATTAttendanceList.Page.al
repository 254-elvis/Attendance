page 50151 "ATT Attendance List"
{
    Caption = 'Attendance Entries';
    PageType = List;
    SourceTable = "ATT Attendance Entry";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "ATT Attendance Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                    ToolTip = 'Specifies whether the employee was present or absent, and whether they apologised.';
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time the employee arrived.';
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time the employee left.';
                }
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hours between Time In and Time Out.';
                }
                field(Late; Rec.Late)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the employee arrived after the start time.';
                }
                field("Apology Reason"; Rec."Apology Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason given in the apology.';
                    ShowMandatory = Rec.Status = Rec.Status::"Absent With Apology";
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClockIn)
            {
                Caption = 'Clock In';
                ApplicationArea = All;
                Image = Start;
                ToolTip = 'Records the current time as the arrival time for the selected employee today.';

                trigger OnAction()
                var
                    AttendanceMgt: Codeunit "ATT Attendance Mgt";
                begin
                    AttendanceMgt.ClockIn(Rec."Employee No.");
                    CurrPage.Update(false);
                end;
            }
            action(ClockOut)
            {
                Caption = 'Clock Out';
                ApplicationArea = All;
                Image = Stop;
                ToolTip = 'Records the current time as the departure time for the selected employee today.';

                trigger OnAction()
                var
                    AttendanceMgt: Codeunit "ATT Attendance Mgt";
                begin
                    AttendanceMgt.ClockOut(Rec."Employee No.");
                    CurrPage.Update(false);
                end;
            }
            action(ShowToday)
            {
                Caption = 'Today';
                ApplicationArea = All;
                Image = Filter;
                ToolTip = 'Shows only today''s entries.';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("Attendance Date", Today);
                    CurrPage.Update(false);
                end;
            }
            action(ShowThisWeek)
            {
                Caption = 'This Week';
                ApplicationArea = All;
                Image = Filter;
                ToolTip = 'Shows entries from Monday to Sunday of this week.';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("Attendance Date", CalcDate('<-CW>', Today), CalcDate('<CW>', Today));
                    CurrPage.Update(false);
                end;
            }
            action(ShowAbsent)
            {
                Caption = 'Absent Only';
                ApplicationArea = All;
                Image = Filter;
                ToolTip = 'Shows only entries where the employee was absent.';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetFilter(Status, '%1|%2', Rec.Status::"Absent With Apology", Rec.Status::"Absent Without Apology");
                    CurrPage.Update(false);
                end;
            }
            action(ShowAll)
            {
                Caption = 'Show All';
                ApplicationArea = All;
                Image = ClearFilter;
                ToolTip = 'Removes all filters and shows every entry.';

                trigger OnAction()
                begin
                    Rec.Reset();
                    CurrPage.Update(false);
                end;
            }
            action(Recalculate)
            {
                Caption = 'Recalculate';
                ApplicationArea = All;
                Image = Calculate;
                ToolTip = 'Fills in employee name, hours worked and late flag for all entries, including older ones.';

                trigger OnAction()
                var
                    Entry: Record "ATT Attendance Entry";
                begin
                    if Entry.FindSet() then
                        repeat
                            Entry.Modify(true);
                        until Entry.Next() = 0;
                    CurrPage.Update(false);
                    Message('All entries have been recalculated.');
                end;
            }
            action(MarkOnLeave)
            {
                Caption = 'Mark Employees On Leave';
                ApplicationArea = All;
                Image = Calendar;
                ToolTip = 'Creates On Leave entries for today for employees who have an absence record covering today.';

                trigger OnAction()
                var
                    AttendanceMgt: Codeunit "ATT Attendance Mgt";
                    Created: Integer;
                begin
                    Created := AttendanceMgt.MarkEmployeesOnLeave(Today);
                    CurrPage.Update(false);
                    Message('%1 employee(s) marked On Leave for today.', Created);
                end;
            }
        }
        area(Promoted)
        {
            actionref(ClockIn_Promoted; ClockIn) { }
            actionref(ClockOut_Promoted; ClockOut) { }
            actionref(ShowToday_Promoted; ShowToday) { }
            actionref(ShowThisWeek_Promoted; ShowThisWeek) { }
            actionref(ShowAbsent_Promoted; ShowAbsent) { }
            actionref(ShowAll_Promoted; ShowAll) { }
            actionref(Recalculate_Promoted; Recalculate) { }
            actionref(MarkOnLeave_Promoted; MarkOnLeave) { }
        }
    }
}