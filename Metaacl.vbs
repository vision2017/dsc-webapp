
set Args = wscript.Arguments
if Args.Count < 1 then
    wscript.echo "Usage: MetaACL <metabase path> [username] [permissions | /d]"
    wscript.echo "         - no username will show all acls on metabase path"
    wscript.echo "         - username with no permissions will show permissions for that user "
    wscript.echo "            or group"
    wscript.echo "         - username with permissions will set those permissions for that "
    wscript.echo "            user or group"
    wscript.echo "         - permissions is a string of the following charcaters 'RWSUED'"
    wscript.echo "               R - Read"
    wscript.echo "               W - Write"
    wscript.echo "               S - Restricted Write"
    wscript.echo "               U - Unsecure properties read"
    wscript.echo "               E - Enumerate Keys"
    wscript.echo "               D - Write DACL (permissions)"
    wscript.echo "         - /d = delete that user or group from the ACL"
    wscript.echo ""
    wscript.echo "    Example:  MetaACL ""IIS://Localhost/W3SVC"" MYDOMAIN\Joebob RW"
    wscript.Quit
end if

metapath = Args(0)
if Args.Count = 1 then
    DumpAcl(metapath)
    wscript.Quit
end if

username = Args(1)
if Args.Count = 2 then
    DumpUserAce metapath, username
    wscript.Quit
end if

if Args(2) = "/d" then
    DeleteUserAce metapath, username
end if

bitmask = CreateMask(Args(2))
AddMetaAce metapath, username, bitmask
wscript.Quit

Sub AddMetaAce (path, user, mask)
    On Error Resume Next
    set obj = GetObject(path)
    if Err.Number <> 0 then
        wscript.echo Err.Number
        wscript.echo path
    end if
    set objAcl = obj.AdminAcl
    if Err.Number <> 0 then
        wscript.echo "    Error reading property: " + Err.Number + " " + Err.Description
        wscript.echo path
        wscript.Quit
    end if
    set objDACL = objAcl.DiscretionaryACL
    
    for each objACE in objDACL
        if objACE.Trustee = user then
            objDACL.RemoveAce(objACE)
            Set Ace = CreateObject("AccessControlEntry")
            Ace.Trustee = user
            Ace.AccessMask = mask
            objDACL.AddAce(Ace)
			objAcl.DiscretionaryACL = objDACL
			obj.AdminAcl = objAcl
			obj.SetInfo
			wscript.echo "ACE for " & user & " changed."
			wscript.Quit
        end if
    Next
    
    ' The user wasn't in the DACL, add them now
    Set Ace = CreateObject("AccessControlEntry")
    Ace.Trustee = user
    Ace.AccessMask = mask
    objDACL.AddAce(Ace)
	objAcl.DiscretionaryACL = objDACL
	obj.AdminAcl = objAcl
	if Err.Number <> 0 then
	   wscript.echo "error setting acl: " + Err.Number + ", " + Err.Description
	end if
	obj.SetInfo
	if Err.Number <> 0 then
	   wscript.echo "error setting info: " + Err.Number + ", " + Err.Description
	end if
	
    wscript.echo "ACE for " & user & " added."
    wscript.Quit

End Sub

Function CreateMask(strMask)
    mask = 0
    NumChars = Len(strMask)
    for i = 1 To NumChars 
        char = Mid(strMask, i, 1)
        Select Case char
            Case "R" mask = mask + &H1
            Case "W" mask = mask + &H2
            Case "S" mask = mask + &H20
            Case "U" mask = mask + &H80
            Case "E" mask = mask + &H8
            Case "D" mask = mask + &H40000
        End Select
    Next
    CreateMask = mask
End Function

Sub DeleteUserAce (path, user)
    set obj = GetObject(path)
    if Err.Number <> 0 then
        wscript.echo Err.Number
        wscript.echo path
    end if
    set objAcl = obj.AdminAcl
    if Err.Number <> 0 then
        if Err.Number = 438 then 'Object doesn't support this property or method
            wscript.echo "    AdminAcl property does not exist on this object"
            wscript.Quit
        else
            wscript.echo "    Error: " + Err.Number + " " + Err.Description
            wscript.echo path
            wscript.Quit
        end if
    end if
    set objDACL = objAcl.DiscretionaryACL
    
    for each objACE in objDACL
        if objACE.Trustee = user then
            objDACL.RemoveAce(objACE)
			objAcl.DiscretionaryACL = objDACL
			obj.AdminAcl = objAcl
			obj.SetInfo
			wscript.echo "ACE for " & user & " deleted."
			wscript.Quit
        end if
    Next
    wscript.echo "No ACE for " & user & " found."
    wscript.Quit
End Sub

Sub DumpUserAce(path, user)
    on error resume next
    set obj = GetObject(path)
    if Err.Number <> 0 then
        wscript.echo Err.Number
        wscript.echo path
    end if
    set objAcl = obj.AdminAcl
    if Err.Number <> 0 then
        if Err.Number = 438 then 'Object doesn't support this property or method
            wscript.echo "    AdminAcl property does not exist on this object"
            wscript.Quit
        else
            wscript.echo "    Error: " + Err.Number + " " + Err.Description
            wscript.echo path
            wscript.Quit
        end if
    end if
    set objDACL = objAcl.DiscretionaryACL

    for each objACE in objDACL
        if objACE.Trustee = user then
	        mask = GetMaskString(objACE.AccessMask)
		    wscript.echo objACE.Trustee 
			wscript.echo "    Access:              " & mask
			wscript.echo "    Type:                " & CStr(objACE.AceType)
			wscript.echo "    AceFlags:            " & CStr(objACE.AceFlags)
			wscript.echo "    Flags:               " & CStr(objACE.Flags)
			wscript.echo "    ObjectType:          " & objACE.ObjectType
			wscript.echo "    InheritedObjectType: " & objAce.InheritedObjectType
			wscript.Quit
		end if
    next
    wscript.echo "    No ACE in ACL for " & user
    wscript.Quit
End Sub

Sub DumpAcl(path)
    on error resume next
    set obj = GetObject(path)
    if Err.Number <> 0 then
        wscript.echo Err.Number
        wscript.echo path
        ReportError()
    end if
    set objAcl = obj.AdminAcl
    if Err.Number <> 0 then
        if Err.Number = 438 then 'Object doesn't support this property or method
            wscript.echo "    AdminAcl property does not exist on this object"
            wscript.Quit
        else
            wscript.echo "    Error: " + Err.Number + " " + Err.Description
            wscript.echo path
            wscript.Quit
        end if
    end if
    set objDACL = objAcl.DiscretionaryACL

    for each objACE in objDACL
        mask = GetMaskString(objACE.AccessMask)
        wscript.echo objACE.Trustee 
        wscript.echo "    Access: " & mask
    next
End Sub

Function GetMaskString(mask)
    if (mask and &H1) <> 0 then
        maskstr = "R"
    else
        maskstr = " "
    end if
    if (mask and &H2) <> 0 then
        maskstr = maskstr + "W"
    else
        maskstr = maskstr + " "
    end if
    if (mask and &H20) <> 0 then
        maskstr = maskstr + "S"
    else
        maskstr = maskstr + " "
    end if
    if (mask and &H80) <> 0 then
        maskstr = maskstr + "U"
    else
        maskstr = maskstr + " "
    end if
    if (mask and &H8) <> 0 then
        maskstr = maskstr + "E"
    else
        maskstr = maskstr + " "
    end if
    if (mask and &H40000) <> 0 then
        maskstr = maskstr + "D"
    else
        maskstr = maskstr + " "
    end if

    GetMaskString = maskstr
End Function