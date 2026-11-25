page 50153 "ATT Attendance Role Center"
{
    Caption = 'Attendance';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Activities; "ATT Attendance Activities")
            {
                ApplicationArea = All;
            }
            part(RecentAttendance; "ATT Attendance Part")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(NewEntry)
            {
                Caption = 'New Attendance Entry';
                ApplicationArea = All;
                RunObject = page "ATT Attendance Card";
                RunPageMode = Create;
            }
            action(NewRemote)
            {
                Caption = 'Work From Home';
                ApplicationArea = All;
                RunObject = page "ATT WFH Request";
                RunPageMode = Create;
            }
        }
        area(Sections)
        {
            group(AttendanceGroup)
            {
                Caption = 'Attendance';
                action(AttendanceEntries)
                {
                    Caption = 'Attendance Entries';
                    ApplicationArea = All;
                    RunObject = page "ATT Attendance List";
                }
                action(Employees)
                {
                    Caption = 'Employees';
                    ApplicationArea = All;
                    RunObject = page "Employee List";
                }
            }
            group(RemoteWorkGroup)
            {
                Caption = 'Remote Work';
                action(RemoteEntries)
                {
                    Caption = 'Remote Entries';
                    ApplicationArea = All;
                    RunObject = page "ATT Remote Work List";
                }
                action(RequestWFH)
                {
                    Caption = 'Request Work From Home';
                    ApplicationArea = All;
                    RunObject = page "ATT WFH Request";
                    RunPageMode = Create;
                }
            }
        }
    }
}