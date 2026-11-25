enum 50154 "ATT Attendance Status"
{
    Extensible = true;

    value(0; Present) { Caption = 'Present'; }
    value(1; "Absent With Apology") { Caption = 'Absent With Apology'; }
    value(2; "Absent Without Apology") { Caption = 'Absent Without Apology'; }
    value(3; "On Leave") { Caption = 'On Leave'; }
    value(4; "Work From Home") { Caption = 'Work From Home'; }
}