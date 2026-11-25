codeunit 50157 "ATT Attendance Mgt"
{
    procedure ClockIn(EmployeeNo: Code[20])
    var
        Entry: Record "ATT Attendance Entry";
    begin
        if EmployeeNo = '' then
            Error('Select an employee first.');

        Entry.SetRange("Employee No.", EmployeeNo);
        Entry.SetRange("Attendance Date", Today);
        if Entry.FindFirst() then begin
            if Entry."Time In" <> 0T then
                Error('Employee %1 already clocked in today at %2.', EmployeeNo, Entry."Time In");
            if Entry.Status <> Entry.Status::"Work From Home" then
                Entry.Validate(Status, Entry.Status::Present);
            Entry."Time In" := Time;
            Entry.Modify(true);
        end else begin
            Entry.Init();
            Entry."Employee No." := EmployeeNo;
            Entry."Attendance Date" := Today;
            Entry.Validate(Status, Entry.Status::Present);
            Entry."Time In" := Time;
            Entry.Insert(true);
        end;
        Message('Clocked in at %1.', Time);
    end;

    procedure ClockOut(EmployeeNo: Code[20])
    var
        Entry: Record "ATT Attendance Entry";
    begin
        if EmployeeNo = '' then
            Error('Select an employee first.');

        Entry.SetRange("Employee No.", EmployeeNo);
        Entry.SetRange("Attendance Date", Today);
        if not Entry.FindFirst() then
            Error('Employee %1 has not clocked in today.', EmployeeNo);
        if Entry."Time In" = 0T then
            Error('Employee %1 has not clocked in today.', EmployeeNo);
        if Entry."Time Out" <> 0T then
            Error('Employee %1 already clocked out today at %2.', EmployeeNo, Entry."Time Out");

        Entry."Time Out" := Time;
        Entry.Modify(true);
        Message('Clocked out at %1.', Time);
    end;

    procedure MarkEmployeesOnLeave(ForDate: Date): Integer
    var
        Absence: Record "Employee Absence";
        Entry: Record "ATT Attendance Entry";
        Counter: Integer;
    begin
        Absence.SetFilter("From Date", '<=%1', ForDate);
        Absence.SetFilter("To Date", '>=%1', ForDate);
        if Absence.FindSet() then
            repeat
                Entry.Reset();
                Entry.SetRange("Employee No.", Absence."Employee No.");
                Entry.SetRange("Attendance Date", ForDate);
                if Entry.IsEmpty() then begin
                    Entry.Init();
                    Entry."Employee No." := Absence."Employee No.";
                    Entry."Attendance Date" := ForDate;
                    Entry.Validate(Status, Entry.Status::"On Leave");
                    Entry.Insert(true);
                    Counter += 1;
                end;
            until Absence.Next() = 0;
        exit(Counter);
    end;
}