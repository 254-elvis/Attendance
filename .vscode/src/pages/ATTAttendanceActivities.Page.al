page 50156 "ATT Attendance Activities"
{
    Caption = 'Attendance Today';
    PageType = CardPart;
    SourceTable = "ATT Attendance Cue";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(Today)
            {
                Caption = 'Today';

                field("Present Today"; Rec."Present Today")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many employees are marked present today.';
                }
                field("Working From Home"; Rec."Working From Home")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many employees are working from home today.';
                }
                field("Absent With Apology"; Rec."Absent With Apology")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many employees are absent today and sent an apology.';
                }
                field("Absent Without Apology"; Rec."Absent Without Apology")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many employees are absent today without an apology.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.SetRange("Date Filter", Today);
    end;
}