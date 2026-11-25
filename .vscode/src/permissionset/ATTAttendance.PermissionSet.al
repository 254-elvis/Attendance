permissionset 50158 "ATT ATTENDANCE"
{
    Assignable = true;
    Caption = 'Attendance';

    Permissions =
        tabledata "ATT Attendance Entry" = RIMD,
        tabledata "ATT Attendance Cue" = RIMD,
        tabledata Employee = R,
        table "ATT Attendance Entry" = X,
        table "ATT Attendance Cue" = X,
        page "ATT Attendance List" = X,
        page "ATT Attendance Card" = X,
        page "ATT Attendance Part" = X,
        page "ATT Attendance Activities" = X,
        page "ATT Attendance Role Center" = X,
        page "ATT Remote Work List" = X,
        page "ATT WFH Request" = X,
        codeunit "ATT Attendance Mgt" = X;
}