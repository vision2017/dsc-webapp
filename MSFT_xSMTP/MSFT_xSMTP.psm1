# Load the Helper Module
Import-Module -Name "$PSScriptRoot\..\Helper.psm1"

# Localized messages
data LocalizedData
{
    # culture="en-US"
    ConvertFrom-StringData -StringData @'
        ErrorSMTPDiscoveryFailure              = No SMTP Virutal server found.
        ErrorLogFileDirectoryFailure           = Invalid LogFileDirectory provided.
        ErrorBadMailDirectoryFailure           = Invalid BadMailDirectory provided.
        ErrorIPAddressFailure                  = Invalid IP address(s), please verifiy the IP addresse(s) are valid
        ErrorEmailAddressFailure               = Invalid Email address(s), please verifiy the Email addresse(s) are valid 
        ErrorBindingsPortFailure               = Invalid Port Range, please verifiy the port(s) are valid.
        VerboseTestTargetResource              = SMTPSetting "{0}" is not correct.
        VerboseTestTargetFalseBadMailDirectory = BadMailDirectory is not in the desired state.
        VerboseTestTargetFalseLogFileDirectory = LogFileDirectory is not in the desired state.
        VerboseTestTargetFalseSendNdrTo        = SendNdrTo is not in the desired state.
        VerboseTestTargetFalseServerBindings   = ServerBindings is not in the desired state.
        VerboseSetTargetBadMailDirectory       = Updated SMTP Setting BadMailDirectory.       
        VerboseSetTargetLogFileDirectory       = Updated SMTP Setting LogFileDirectory.
        VerboseSetTargetSendNdrTo              = Updated SMTP Setting SendNdrTo.
        VerboseSetTargetServerBindings         = Updated SMTP Setting ServerBindings.
        VerboseSetTargetResourceUpdated        = Updated SMTPSetting "{0}".
'@
}
<#
    This is an array of all the parameters used by this resource
    It can be used by several of the functions to reduce the amount of code required
    Each element contains 3 properties:
    Name: The parameter name
    Source: The source where the existing parameter can be pulled from
    Type: This is the content type of the paramater (it is either array, string, boolean or blank)
#> 
data ParameterList
{
    @( 
        @{
			Name	= 'AccessExecute'
			Source	= '$CurrentSMTP.AccessExecute'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessFlags'
			Source	= '$CurrentSMTP.AccessFlags'
			Type	= 'Int'
		}
		@{
			Name	= 'AccessNoPhysicalDir'
			Source	= '$CurrentSMTP.AccessNoPhysicalDir'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessNoRemoteExecute'
			Source	= '$CurrentSMTP.AccessNoRemoteExecute'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessNoRemoteRead'
			Source	= '$CurrentSMTP.AccessNoRemoteRead'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessNoRemoteScript'
			Source	= '$CurrentSMTP.AccessNoRemoteScript'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessNoRemoteWrite'
			Source	= '$CurrentSMTP.AccessNoRemoteWrite'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessRead'
			Source	= '$CurrentSMTP.AccessRead'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessScript'
			Source	= '$CurrentSMTP.AccessScript'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessSource'
			Source	= '$CurrentSMTP.AccessSource'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessSSL'
			Source	= '$CurrentSMTP.AccessSSL'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessSSL128'
			Source	= '$CurrentSMTP.AccessSSL128'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessSSLFlags'
			Source	= '$CurrentSMTP.AccessSSLFlags'
			Type	= 'Int'
		}
		@{
			Name	= 'AccessSSLMapCert'
			Source	= '$CurrentSMTP.AccessSSLMapCert'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessSSLNegotiateCert'
			Source	= '$CurrentSMTP.AccessSSLNegotiateCert'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessSSLRequireCert'
			Source	= '$CurrentSMTP.AccessSSLRequireCert'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AccessWrite'
			Source	= '$CurrentSMTP.AccessWrite'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AddNoHeaders'
			Source	= '$CurrentSMTP.AddNoHeaders'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AdminACLBin'
			Source	= '$CurrentSMTP.AdminACLBin'
			Type	= 'Byte[]'
		}
		@{
			Name	= 'AllowAnonymous'
			Source	= '$CurrentSMTP.AllowAnonymous'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AlwaysUseSsl'
			Source	= '$CurrentSMTP.AlwaysUseSsl'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AnonymousOnly'
			Source	= '$CurrentSMTP.AnonymousOnly'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AnonymousPasswordSync'
			Source	= '$CurrentSMTP.AnonymousPasswordSync'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AnonymousUserName'
			Source	= '$CurrentSMTP.AnonymousUserName'
			Type	= 'String'
		}
		@{
			Name	= 'AuthAnonymous'
			Source	= '$CurrentSMTP.AuthAnonymous'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AuthBasic'
			Source	= '$CurrentSMTP.AuthBasic'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AuthFlags'
			Source	= '$CurrentSMTP.AuthFlags'
			Type	= 'Int'
		}
		@{
			Name	= 'AuthMD5'
			Source	= '$CurrentSMTP.AuthMD5'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AuthNTLM'
			Source	= '$CurrentSMTP.AuthNTLM'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AuthPassport'
			Source	= '$CurrentSMTP.AuthPassport'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AzEnable'
			Source	= '$CurrentSMTP.AzEnable'
			Type	= 'Boolean'
		}
		@{
			Name	= 'AzScopeName'
			Source	= '$CurrentSMTP.AzScopeName'
			Type	= 'String'
		}
		@{
			Name	= 'AzStoreName'
			Source	= '$CurrentSMTP.AzStoreName'
			Type	= 'String'
		}
		@{
			Name	= 'BadMailDirectory'
			Source	= '$CurrentSMTP.BadMailDirectory'
			Type	= 'String'
		}
		@{
			Name	= 'Caption'
			Source	= '$CurrentSMTP.Caption'
			Type	= 'String'
		}
		@{
			Name	= 'ClusterEnabled'
			Source	= '$CurrentSMTP.ClusterEnabled'
			Type	= 'Boolean'
		}
		@{
			Name	= 'ConnectionTimeout'
			Source	= '$CurrentSMTP.ConnectionTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'ConnectResponse'
			Source	= '$CurrentSMTP.ConnectResponse'
			Type	= 'String'
		}
		@{
			Name	= 'DefaultDomain'
			Source	= '$CurrentSMTP.DefaultDomain'
			Type	= 'String'
		}
		@{
			Name	= 'DefaultLogonDomain'
			Source	= '$CurrentSMTP.DefaultLogonDomain'
			Type	= 'String'
		}
		@{
			Name	= 'Description'
			Source	= '$CurrentSMTP.Description'
			Type	= 'String'
		}
		@{
			Name	= 'DisableSocketPooling'
			Source	= '$CurrentSMTP.DisableSocketPooling'
			Type	= 'Boolean'
		}
		@{
			Name	= 'DoMasquerade'
			Source	= '$CurrentSMTP.DoMasquerade'
			Type	= 'Boolean'
		}
		@{
			Name	= 'DontLog'
			Source	= '$CurrentSMTP.DontLog'
			Type	= 'Boolean'
		}
		@{
			Name	= 'DropDirectory'
			Source	= '$CurrentSMTP.DropDirectory'
			Type	= 'String'
		}
		@{
			Name	= 'EnableReverseDnsLookup'
			Source	= '$CurrentSMTP.EnableReverseDnsLookup'
			Type	= 'Boolean'
		}
		@{
			Name	= 'EtrnDays'
			Source	= '$CurrentSMTP.EtrnDays'
			Type	= 'Int'
		}
		@{
			Name	= 'EtrnSubdomains'
			Source	= '$CurrentSMTP.EtrnSubdomains'
			Type	= 'Boolean'
		}
		@{
			Name	= 'FullyQualifiedDomainName'
			Source	= '$CurrentSMTP.FullyQualifiedDomainName'
			Type	= 'String'
		}
		@{
			Name	= 'HopCount'
			Source	= '$CurrentSMTP.HopCount'
			Type	= 'Int'
		}
		@{
			Name	= 'LimitRemoteConnections'
			Source	= '$CurrentSMTP.LimitRemoteConnections'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LocalRetryAttempts'
			Source	= '$CurrentSMTP.LocalRetryAttempts'
			Type	= 'Int'
		}
		@{
			Name	= 'LocalRetryInterval'
			Source	= '$CurrentSMTP.LocalRetryInterval'
			Type	= 'Int'
		}
		@{
			Name	= 'LogExtFileBytesRecv'
			Source	= '$CurrentSMTP.LogExtFileBytesRecv'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileBytesSent'
			Source	= '$CurrentSMTP.LogExtFileBytesSent'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileClientIp'
			Source	= '$CurrentSMTP.LogExtFileClientIp'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileComputerName'
			Source	= '$CurrentSMTP.LogExtFileComputerName'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileCookie'
			Source	= '$CurrentSMTP.LogExtFileCookie'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileDate'
			Source	= '$CurrentSMTP.LogExtFileDate'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileFlags'
			Source	= '$CurrentSMTP.LogExtFileFlags'
			Type	= 'Int'
		}
		@{
			Name	= 'LogExtFileHost'
			Source	= '$CurrentSMTP.LogExtFileHost'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileHttpStatus'
			Source	= '$CurrentSMTP.LogExtFileHttpStatus'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileHttpSubStatus'
			Source	= '$CurrentSMTP.LogExtFileHttpSubStatus'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileMethod'
			Source	= '$CurrentSMTP.LogExtFileMethod'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileProtocolVersion'
			Source	= '$CurrentSMTP.LogExtFileProtocolVersion'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileReferer'
			Source	= '$CurrentSMTP.LogExtFileReferer'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileServerIp'
			Source	= '$CurrentSMTP.LogExtFileServerIp'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileServerPort'
			Source	= '$CurrentSMTP.LogExtFileServerPort'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileSiteName'
			Source	= '$CurrentSMTP.LogExtFileSiteName'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileTime'
			Source	= '$CurrentSMTP.LogExtFileTime'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileTimeTaken'
			Source	= '$CurrentSMTP.LogExtFileTimeTaken'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileUriQuery'
			Source	= '$CurrentSMTP.LogExtFileUriQuery'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileUriStem'
			Source	= '$CurrentSMTP.LogExtFileUriStem'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileUserAgent'
			Source	= '$CurrentSMTP.LogExtFileUserAgent'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileUserName'
			Source	= '$CurrentSMTP.LogExtFileUserName'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogExtFileWin32Status'
			Source	= '$CurrentSMTP.LogExtFileWin32Status'
			Type	= 'Boolean'
		}
		@{
			Name	= 'LogFileDirectory'
			Source	= '$CurrentSMTP.LogFileDirectory'
			Type	= 'String'
		}
		@{
			Name	= 'LogFilePeriod'
			Source	= '$CurrentSMTP.LogFilePeriod'
			Type	= 'Int'
		}
		@{
			Name	= 'LogFileTruncateSize'
			Source	= '$CurrentSMTP.LogFileTruncateSize'
			Type	= 'Int'
		}
		@{
			Name	= 'LogOdbcDataSource'
			Source	= '$CurrentSMTP.LogOdbcDataSource'
			Type	= 'String'
		}
		@{
			Name	= 'LogOdbcPassword'
			Source	= '$CurrentSMTP.LogOdbcPassword'
			Type	= 'String'
		}
		@{
			Name	= 'LogOdbcTableName'
			Source	= '$CurrentSMTP.LogOdbcTableName'
			Type	= 'String'
		}
		@{
			Name	= 'LogOdbcUserName'
			Source	= '$CurrentSMTP.LogOdbcUserName'
			Type	= 'String'
		}
		@{
			Name	= 'LogPluginClsid'
			Source	= '$CurrentSMTP.LogPluginClsid'
			Type	= 'String'
		}
		@{
			Name	= 'LogType'
			Source	= '$CurrentSMTP.LogType'
			Type	= 'Int'
		}
		@{
			Name	= 'MasqueradeDomain'
			Source	= '$CurrentSMTP.MasqueradeDomain'
			Type	= 'String'
		}
		@{
			Name	= 'MaxBandwidth'
			Source	= '$CurrentSMTP.MaxBandwidth'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxBatchedMessages'
			Source	= '$CurrentSMTP.MaxBatchedMessages'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxConnections'
			Source	= '$CurrentSMTP.MaxConnections'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxDirChangeIOSize'
			Source	= '$CurrentSMTP.MaxDirChangeIOSize'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxEndpointConnections'
			Source	= '$CurrentSMTP.MaxEndpointConnections'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxMailObjects'
			Source	= '$CurrentSMTP.MaxMailObjects'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxMessageSize'
			Source	= '$CurrentSMTP.MaxMessageSize'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxOutConnections'
			Source	= '$CurrentSMTP.MaxOutConnections'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxOutConnectionsPerDomain'
			Source	= '$CurrentSMTP.MaxOutConnectionsPerDomain'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxRecipients'
			Source	= '$CurrentSMTP.MaxRecipients'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxSessionSize'
			Source	= '$CurrentSMTP.MaxSessionSize'
			Type	= 'Int'
		}
		@{
			Name	= 'MaxSmtpErrors'
			Source	= '$CurrentSMTP.MaxSmtpErrors'
			Type	= 'Int'
		}
		@{
			Name	= 'NameResolutionType'
			Source	= '$CurrentSMTP.NameResolutionType'
			Type	= 'Int'
		}
		@{
			Name	= 'NTAuthenticationProviders'
			Source	= '$CurrentSMTP.NTAuthenticationProviders'
			Type	= 'String'
		}
		@{
			Name	= 'PickupDirectory'
			Source	= '$CurrentSMTP.PickupDirectory'
			Type	= 'String'
		}
		@{
			Name	= 'QueueDirectory'
			Source	= '$CurrentSMTP.QueueDirectory'
			Type	= 'String'
		}
		@{
			Name	= 'Realm'
			Source	= '$CurrentSMTP.Realm'
			Type	= 'String'
		}
		@{
			Name	= 'RelayForAuth'
			Source	= '$CurrentSMTP.RelayForAuth'
			Type	= 'Int'
		}
		@{
			Name	= 'RelayIpList'
			Source	= '$CurrentSMTP.RelayIpList'
			Type	= 'Byte[]'
		}
		@{
			Name	= 'RemoteRetryAttempts'
			Source	= '$CurrentSMTP.RemoteRetryAttempts'
			Type	= 'Int'
		}
		@{
			Name	= 'RemoteRetryInterval'
			Source	= '$CurrentSMTP.RemoteRetryInterval'
			Type	= 'Int'
		}
		@{
			Name	= 'RemoteSmtpPort'
			Source	= '$CurrentSMTP.RemoteSmtpPort'
			Type	= 'Int'
		}
		@{
			Name	= 'RemoteSmtpSecurePort'
			Source	= '$CurrentSMTP.RemoteSmtpSecurePort'
			Type	= 'Int'
		}
		@{
			Name	= 'RemoteTimeout'
			Source	= '$CurrentSMTP.RemoteTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'RouteAction'
			Source	= '$CurrentSMTP.RouteAction'
			Type	= 'Int'
		}
		@{
			Name	= 'RoutePassword'
			Source	= '$CurrentSMTP.RoutePassword'
			Type	= 'String'
		}
		@{
			Name	= 'RouteUserName'
			Source	= '$CurrentSMTP.RouteUserName'
			Type	= 'String'
		}
		@{
			Name	= 'RoutingDll'
			Source	= '$CurrentSMTP.RoutingDll'
			Type	= 'String'
		}
		@{
			Name	= 'SaslLogonDomain'
			Source	= '$CurrentSMTP.SaslLogonDomain'
			Type	= 'String'
		}
		@{
			Name	= 'SecureBindings'
			Source	= '$CurrentSMTP.SecureBindings'
			Type	= 'Object[]'
		}
		@{
			Name	= 'SendBadTo'
			Source	= '$CurrentSMTP.SendBadTo'
			Type	= 'String'
		}
		@{
			Name	= 'SendNdrTo'
			Source	= '$CurrentSMTP.SendNdrTo'
			Type	= 'String'
		}
		@{
			Name	= 'ServerAutoStart'
			Source	= '$CurrentSMTP.ServerAutoStart'
			Type	= 'Boolean'
		}
		@{
			Name	= 'ServerBindings'
			Source	= '$CurrentSMTP.ServerBindings'
			Type	= 'Object[]'
		}
		@{
			Name	= 'ServerComment'
			Source	= '$CurrentSMTP.ServerComment'
			Type	= 'String'
		}
		@{
			Name	= 'ServerListenBacklog'
			Source	= '$CurrentSMTP.ServerListenBacklog'
			Type	= 'Int'
		}
		@{
			Name	= 'ServerListenTimeout'
			Source	= '$CurrentSMTP.ServerListenTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SettingID'
			Source	= '$CurrentSMTP.SettingID'
			Type	= 'String'
		}
		@{
			Name	= 'ShouldDeliver'
			Source	= '$CurrentSMTP.ShouldDeliver'
			Type	= 'Boolean'
		}
		@{
			Name	= 'ShouldPickupMail'
			Source	= '$CurrentSMTP.ShouldPickupMail'
			Type	= 'Boolean'
		}
		@{
			Name	= 'ShouldPipelineIn'
			Source	= '$CurrentSMTP.ShouldPipelineIn'
			Type	= 'Boolean'
		}
		@{
			Name	= 'ShouldPipelineOut'
			Source	= '$CurrentSMTP.ShouldPipelineOut'
			Type	= 'Boolean'
		}
		@{
			Name	= 'SmartHost'
			Source	= '$CurrentSMTP.SmartHost'
			Type	= 'String'
		}
		@{
			Name	= 'SmartHostType'
			Source	= '$CurrentSMTP.SmartHostType'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpAqueueWait'
			Source	= '$CurrentSMTP.SmtpAqueueWait'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpAuthTimeout'
			Source	= '$CurrentSMTP.SmtpAuthTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpBdatTimeout'
			Source	= '$CurrentSMTP.SmtpBdatTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpClearTextProvider'
			Source	= '$CurrentSMTP.SmtpClearTextProvider'
			Type	= 'String'
		}
		@{
			Name	= 'SmtpConnectTimeout'
			Source	= '$CurrentSMTP.SmtpConnectTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpDataTimeout'
			Source	= '$CurrentSMTP.SmtpDataTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpDisableRelay'
			Source	= '$CurrentSMTP.SmtpDisableRelay'
			Type	= 'Boolean'
		}
		@{
			Name	= 'SmtpDomainValidationFlags'
			Source	= '$CurrentSMTP.SmtpDomainValidationFlags'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpDotStuffPickupDirFiles'
			Source	= '$CurrentSMTP.SmtpDotStuffPickupDirFiles'
			Type	= 'Boolean'
		}
		@{
			Name	= 'SmtpDSNLanguageID'
			Source	= '$CurrentSMTP.SmtpDSNLanguageID'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpDSNOptions'
			Source	= '$CurrentSMTP.SmtpDSNOptions'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpEventlogLevel'
			Source	= '$CurrentSMTP.SmtpEventlogLevel'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpHeloNoDomain'
			Source	= '$CurrentSMTP.SmtpHeloNoDomain'
			Type	= 'Boolean'
		}
		@{
			Name	= 'SmtpHeloTimeout'
			Source	= '$CurrentSMTP.SmtpHeloTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpInboundCommandSupportOptions'
			Source	= '$CurrentSMTP.SmtpInboundCommandSupportOptions'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpIpRestrictionFlag'
			Source	= '$CurrentSMTP.SmtpIpRestrictionFlag'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpLocalDelayExpireMinutes'
			Source	= '$CurrentSMTP.SmtpLocalDelayExpireMinutes'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpLocalNDRExpireMinutes'
			Source	= '$CurrentSMTP.SmtpLocalNDRExpireMinutes'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpMailFromTimeout'
			Source	= '$CurrentSMTP.SmtpMailFromTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpMailNoHelo'
			Source	= '$CurrentSMTP.SmtpMailNoHelo'
			Type	= 'Boolean'
		}
		@{
			Name	= 'SmtpMaxRemoteQThreads'
			Source	= '$CurrentSMTP.SmtpMaxRemoteQThreads'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpOutboundCommandSupportOptions'
			Source	= '$CurrentSMTP.SmtpOutboundCommandSupportOptions'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpRcptToTimeout'
			Source	= '$CurrentSMTP.SmtpRcptToTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpRemoteDelayExpireMinutes'
			Source	= '$CurrentSMTP.SmtpRemoteDelayExpireMinutes'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpRemoteNDRExpireMinutes'
			Source	= '$CurrentSMTP.SmtpRemoteNDRExpireMinutes'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpRemoteProgressiveRetry'
			Source	= '$CurrentSMTP.SmtpRemoteProgressiveRetry'
			Type	= 'String'
		}
		@{
			Name	= 'SmtpRemoteRetryThreshold'
			Source	= '$CurrentSMTP.SmtpRemoteRetryThreshold'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpRsetTimeout'
			Source	= '$CurrentSMTP.SmtpRsetTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpSaslTimeout'
			Source	= '$CurrentSMTP.SmtpSaslTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpSSLCertHostnameValidation'
			Source	= '$CurrentSMTP.SmtpSSLCertHostnameValidation'
			Type	= 'Boolean'
		}
		@{
			Name	= 'SmtpSSLRequireTrustedCA'
			Source	= '$CurrentSMTP.SmtpSSLRequireTrustedCA'
			Type	= 'Boolean'
		}
		@{
			Name	= 'SmtpTurnTimeout'
			Source	= '$CurrentSMTP.SmtpTurnTimeout'
			Type	= 'Int'
		}
		@{
			Name	= 'SmtpUseTcpDns'
			Source	= '$CurrentSMTP.SmtpUseTcpDns'
			Type	= 'Int'
		}
		@{
			Name	= 'UpdatedDefaultDomain'
			Source	= '$CurrentSMTP.UpdatedDefaultDomain'
			Type	= 'Boolean'
		}
		@{
			Name	= 'UpdatedFQDN'
			Source	= '$CurrentSMTP.UpdatedFQDN'
			Type	= 'Boolean'
		}
		@{
			Name	= 'Win32Error'
			Source	= '$CurrentSMTP.Win32Error'
			Type	= 'Int'
		}
    )
}


function Get-TargetResource
{
    <#
    .SYNOPSIS
        This will return a hashtable of results
    #>

    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('1')]
        [String] $ID
    )

    $CurrentSMTP = Get-SMTPSettings -ID $ID
    
    if (-not ($CurrentSMTP))
    {
        return @{
            ID = $ID
        }
    }
    else
    {
        return @{            
            AccessExecute		 	  	  	  = $CurrentSMTP.AccessExecute
			AccessFlags		 	  		  	  = $CurrentSMTP.AccessFlags
			AccessNoPhysicalDir	 	  	  	  = $CurrentSMTP.AccessNoPhysicalDir
			AccessNoRemoteExecute	 	  	  = $CurrentSMTP.AccessNoRemoteExecute
			AccessNoRemoteRead	 	  	  	  = $CurrentSMTP.AccessNoRemoteRead
			AccessNoRemoteScript	 	  	  = $CurrentSMTP.AccessNoRemoteScript
			AccessNoRemoteWrite	 	  	  	  = $CurrentSMTP.AccessNoRemoteWrite
			AccessRead		 	  	  	  	  = $CurrentSMTP.AccessRead
			AccessScript		 	  	  	  = $CurrentSMTP.AccessScript
			AccessSource		 	  	  	  = $CurrentSMTP.AccessSource
			AccessSSL		 	  	  	  	  = $CurrentSMTP.AccessSSL
			AccessSSL128		 	  	  	  = $CurrentSMTP.AccessSSL128
			AccessSSLFlags		 	  	  	  = $CurrentSMTP.AccessSSLFlags
			AccessSSLMapCert	 	  	  	  = $CurrentSMTP.AccessSSLMapCert
			AccessSSLNegotiateCert	 	  	  = $CurrentSMTP.AccessSSLNegotiateCert
			AccessSSLRequireCert	 	   	  = $CurrentSMTP.AccessSSLRequireCert
			AccessWrite		 	  	  	  	  = $CurrentSMTP.AccessWrite
			AddNoHeaders		 	  	  	  = $CurrentSMTP.AddNoHeaders
			AdminACLBin		 	  	  	  	  = $CurrentSMTP.AdminACLBin
			AllowAnonymous		 	  	  	  = $CurrentSMTP.AllowAnonymous
			AlwaysUseSsl		 	  	  	  = $CurrentSMTP.AlwaysUseSsl
			AnonymousOnly		 	  	  	  = $CurrentSMTP.AnonymousOnly
			AnonymousPasswordSync	 	   	  = $CurrentSMTP.AnonymousPasswordSync
			AnonymousUserName	 	  	  	  = $CurrentSMTP.AnonymousUserName
			AuthAnonymous		 	  	  	  = $CurrentSMTP.AuthAnonymous
			AuthBasic		 	  	  	  	  = $CurrentSMTP.AuthBasic
			AuthFlags		 	  	  	  	  = $CurrentSMTP.AuthFlags
			AuthMD5			 	  	  	  	  = $CurrentSMTP.AuthMD5
			AuthNTLM		 	  	  	  	  = $CurrentSMTP.AuthNTLM
			AuthPassport		 	  	   	  = $CurrentSMTP.AuthPassport
			AzEnable		 	  	  	  	  = $CurrentSMTP.AzEnable
			AzScopeName		 	  	  	  	  = $CurrentSMTP.AzScopeName
			AzStoreName		 	  	  	  	  = $CurrentSMTP.AzStoreName
			BadMailDirectory	 	  	  	  = $CurrentSMTP.BadMailDirectory
			Caption			 	  	  	  	  = $CurrentSMTP.Caption
			ClusterEnabled		 	  	  	  = $CurrentSMTP.ClusterEnabled
			ConnectionTimeout	 	  	  	  = $CurrentSMTP.ConnectionTimeout
			ConnectResponse		 	  	  	  = $CurrentSMTP.ConnectResponse
			DefaultDomain		 	  	  	  = $CurrentSMTP.DefaultDomain
			DefaultLogonDomain	 	  	  	  = $CurrentSMTP.DefaultLogonDomain
			Description		 	  	  	  	  = $CurrentSMTP.Description
			DisableSocketPooling	 	   	  = $CurrentSMTP.DisableSocketPooling
			DoMasquerade		 	  	  	  = $CurrentSMTP.DoMasquerade
			DontLog			 	  	  	  	  = $CurrentSMTP.DontLog
			DropDirectory		 	  	  	  = $CurrentSMTP.DropDirectory
			EnableReverseDnsLookup	 	  	  = $CurrentSMTP.EnableReverseDnsLookup
			EtrnDays		 	  	  	 	  = $CurrentSMTP.EtrnDays
			EtrnSubdomains		 	  	  	  = $CurrentSMTP.EtrnSubdomains
			FullyQualifiedDomainName 	   	  = $CurrentSMTP.FullyQualifiedDomainName
			HopCount		 	  	  	 	  = $CurrentSMTP.HopCount
			LimitRemoteConnections	 	  	  = $CurrentSMTP.LimitRemoteConnections
			LocalRetryAttempts	 	  	  	  = $CurrentSMTP.LocalRetryAttempts
			LocalRetryInterval	 	  	  	  = $CurrentSMTP.LocalRetryInterval
			LogExtFileBytesRecv	 	  	  	  = $CurrentSMTP.LogExtFileBytesRecv
			LogExtFileBytesSent	 	  	  	  = $CurrentSMTP.LogExtFileBytesSent
			LogExtFileClientIp	 	  	  	  = $CurrentSMTP.LogExtFileClientIp
			LogExtFileComputerName	 	  	  = $CurrentSMTP.LogExtFileComputerName
			LogExtFileCookie	 	  	  	  = $CurrentSMTP.LogExtFileCookie
			LogExtFileDate		 	  	  	  = $CurrentSMTP.LogExtFileDate
			LogExtFileFlags		 	  	  	  = $CurrentSMTP.LogExtFileFlags
			LogExtFileHost		 	  	  	  = $CurrentSMTP.LogExtFileHost
			LogExtFileHttpStatus	 	  	  = $CurrentSMTP.LogExtFileHttpStatus
			LogExtFileHttpSubStatus	 	  	  = $CurrentSMTP.LogExtFileHttpSubStatus
			LogExtFileMethod	 	  	  	  = $CurrentSMTP.LogExtFileMethod
			LogExtFileProtocolVersion	  	  = $CurrentSMTP.LogExtFileProtocolVersion
			LogExtFileReferer	 	  	  	  = $CurrentSMTP.LogExtFileReferer
			LogExtFileServerIp	 	  	  	  = $CurrentSMTP.LogExtFileServerIp
			LogExtFileServerPort	 	  	  = $CurrentSMTP.LogExtFileServerPort
			LogExtFileSiteName	 	  	  	  = $CurrentSMTP.LogExtFileSiteName
			LogExtFileTime		 	  	  	  = $CurrentSMTP.LogExtFileTime
			LogExtFileTimeTaken	 	  	  	  = $CurrentSMTP.LogExtFileTimeTaken
			LogExtFileUriQuery	 	  	  	  = $CurrentSMTP.LogExtFileUriQuery
			LogExtFileUriStem	 	  	  	  = $CurrentSMTP.LogExtFileUriStem
			LogExtFileUserAgent	 	  	  	  = $CurrentSMTP.LogExtFileUserAgent
			LogExtFileUserName	 	  	  	  = $CurrentSMTP.LogExtFileUserName
			LogExtFileWin32Status	 	  	  = $CurrentSMTP.LogExtFileWin32Status
			LogFileDirectory	 	  	  	  = $CurrentSMTP.LogFileDirectory
			LogFilePeriod		 	  	  	  = $CurrentSMTP.LogFilePeriod
			LogFileTruncateSize	 	  	  	  = $CurrentSMTP.LogFileTruncateSize
			LogOdbcDataSource	 	  	  	  = $CurrentSMTP.LogOdbcDataSource
			LogOdbcPassword		 	  	  	  = $CurrentSMTP.LogOdbcPassword
			LogOdbcTableName	 	  	  	  = $CurrentSMTP.LogOdbcTableName
			LogOdbcUserName		 	  	  	  = $CurrentSMTP.LogOdbcUserName
			LogPluginClsid		 	  	  	  = $CurrentSMTP.LogPluginClsid
			LogType			 	  	  	  	  = $CurrentSMTP.LogType
			MasqueradeDomain	 	  	  	  = $CurrentSMTP.MasqueradeDomain
			MaxBandwidth		 	  	  	  = $CurrentSMTP.MaxBandwidth
			MaxBatchedMessages	 	  	  	  = $CurrentSMTP.MaxBatchedMessages
			MaxConnections		 	  	  	  = $CurrentSMTP.MaxConnections
			MaxDirChangeIOSize	 	  	  	  = $CurrentSMTP.MaxDirChangeIOSize
			MaxEndpointConnections	 	  	  = $CurrentSMTP.MaxEndpointConnections
			MaxMailObjects		 	  	  	  = $CurrentSMTP.MaxMailObjects
			MaxMessageSize		 	  	  	  = $CurrentSMTP.MaxMessageSize
			MaxOutConnections	 	  	  	  = $CurrentSMTP.MaxOutConnections
			MaxOutConnectionsPerDomain	  	  = $CurrentSMTP.MaxOutConnectionsPerDomain
			MaxRecipients		 	  	  	  = $CurrentSMTP.MaxRecipients
			MaxSessionSize		 	  	  	  = $CurrentSMTP.MaxSessionSize
			MaxSmtpErrors		 	  	  	  = $CurrentSMTP.MaxSmtpErrors
			NameResolutionType	 	  	  	  = $CurrentSMTP.NameResolutionType
			NTAuthenticationProviders	  	  = $CurrentSMTP.NTAuthenticationProviders
			PickupDirectory		 	  	  	  = $CurrentSMTP.PickupDirectory
			QueueDirectory		 	  	  	  = $CurrentSMTP.QueueDirectory
			Realm			 	  	  	  	  = $CurrentSMTP.Realm
			RelayForAuth		 	  	  	  = $CurrentSMTP.RelayForAuth
			RelayIpList		 	  	  	  	  = $CurrentSMTP.RelayIpList
			RemoteRetryAttempts	 	  	  	  = $CurrentSMTP.RemoteRetryAttempts
			RemoteRetryInterval	 	  	  	  = $CurrentSMTP.RemoteRetryInterval
			RemoteSmtpPort		 	  	  	  = $CurrentSMTP.RemoteSmtpPort
			RemoteSmtpSecurePort	 	  	  = $CurrentSMTP.RemoteSmtpSecurePort
			RemoteTimeout		 	  	  	  = $CurrentSMTP.RemoteTimeout
			RouteAction		 	  	  	  	  = $CurrentSMTP.RouteAction
			RoutePassword		 	  	  	  = $CurrentSMTP.RoutePassword
			RouteUserName		 	  	  	  = $CurrentSMTP.RouteUserName
			RoutingDll		 	  	  	  	  = $CurrentSMTP.RoutingDll
			SaslLogonDomain		 	  	  	  = $CurrentSMTP.SaslLogonDomain
			SecureBindings		 	  	  	  = $CurrentSMTP.SecureBindings
			SendBadTo		 	  	  	  	  = $CurrentSMTP.SendBadTo
			SendNdrTo		 	  	  	  	  = $CurrentSMTP.SendNdrTo
			ServerAutoStart		 	  	  	  = $CurrentSMTP.ServerAutoStart
			ServerBindings		 	  	  	  = $CurrentSMTP.ServerBindings
			ServerComment		 	  	  	  = $CurrentSMTP.ServerComment
			ServerListenBacklog		  	  	  = $CurrentSMTP.ServerListenBacklog
			ServerListenTimeout		  	  	  = $CurrentSMTP.ServerListenTimeout
			SettingID		 	  	  	  	  = $CurrentSMTP.SettingID
			ShouldDeliver		 	  	  	  = $CurrentSMTP.ShouldDeliver
			ShouldPickupMail		  	  	  = $CurrentSMTP.ShouldPickupMail
			ShouldPipelineIn		  	  	  = $CurrentSMTP.ShouldPipelineIn
			ShouldPipelineOut		  	  	  = $CurrentSMTP.ShouldPipelineOut
			SmartHost		 	  	  		  = $CurrentSMTP.SmartHost
			SmartHostType		 	  	  	  = $CurrentSMTP.SmartHostType
			SmtpAqueueWait		 	  	  	  = $CurrentSMTP.SmtpAqueueWait
			SmtpAuthTimeout		 	  	  	  = $CurrentSMTP.SmtpAuthTimeout
			SmtpBdatTimeout		 		  	  = $CurrentSMTP.SmtpBdatTimeout
			SmtpClearTextProvider	 	  	  = $CurrentSMTP.SmtpClearTextProvider
			SmtpConnectTimeout	 	  		  = $CurrentSMTP.SmtpConnectTimeout
			SmtpDataTimeout		 	  		  = $CurrentSMTP.SmtpDataTimeout
			SmtpDisableRelay	 	  		  = $CurrentSMTP.SmtpDisableRelay
			SmtpDomainValidationFlags	  	  = $CurrentSMTP.SmtpDomainValidationFlags
			SmtpDotStuffPickupDirFiles	  	  = $CurrentSMTP.SmtpDotStuffPickupDirFiles
			SmtpDSNLanguageID	 	  	  	  = $CurrentSMTP.SmtpDSNLanguageID
			SmtpDSNOptions		 	  	  	  = $CurrentSMTP.SmtpDSNOptions
			SmtpEventlogLevel	 	  	  	  = $CurrentSMTP.SmtpEventlogLevel
			SmtpHeloNoDomain	 	  	  	  = $CurrentSMTP.SmtpHeloNoDomain
			SmtpHeloTimeout		 	  	  	  = $CurrentSMTP.SmtpHeloTimeout
			SmtpInboundCommandSupportOptions  = $CurrentSMTP.SmtpInboundCommandSupportOptions
			SmtpIpRestrictionFlag		  	  = $CurrentSMTP.SmtpIpRestrictionFlag
			SmtpLocalDelayExpireMinutes	  	  = $CurrentSMTP.SmtpLocalDelayExpireMinutes
			SmtpLocalNDRExpireMinutes	  	  = $CurrentSMTP.SmtpLocalNDRExpireMinutes
			SmtpMailFromTimeout		  	 	  = $CurrentSMTP.SmtpMailFromTimeout
			SmtpMailNoHelo			  	 	  = $CurrentSMTP.SmtpMailNoHelo
			SmtpMaxRemoteQThreads		  	  = $CurrentSMTP.SmtpMaxRemoteQThreads
			SmtpOutboundCommandSupportOptions = $CurrentSMTP.SmtpOutboundCommandSupportOptions
			SmtpRcptToTimeout		  	  	  = $CurrentSMTP.SmtpRcptToTimeout
			SmtpRemoteDelayExpireMinutes	  = $CurrentSMTP.SmtpRemoteDelayExpireMinutes
			SmtpRemoteNDRExpireMinutes	  	  = $CurrentSMTP.SmtpRemoteNDRExpireMinutes
			SmtpRemoteProgressiveRetry	  	  = $CurrentSMTP.SmtpRemoteProgressiveRetry
			SmtpRemoteRetryThreshold	  	  = $CurrentSMTP.SmtpRemoteRetryThreshold
			SmtpRsetTimeout		  	  	  	  = $CurrentSMTP.SmtpRsetTimeout
			SmtpSaslTimeout			  	 	  = $CurrentSMTP.SmtpSaslTimeout
			SmtpSSLCertHostnameValidation	  = $CurrentSMTP.SmtpSSLCertHostnameValidation
			SmtpSSLRequireTrustedCA		  	  = $CurrentSMTP.SmtpSSLRequireTrustedCA
			SmtpTurnTimeout		 	  	  	  = $CurrentSMTP.SmtpTurnTimeout
			SmtpUseTcpDns			  	  	  = $CurrentSMTP.SmtpUseTcpDns
			UpdatedDefaultDomain		  	  = $CurrentSMTP.UpdatedDefaultDomain
			UpdatedFQDN			  	  		  = $CurrentSMTP.UpdatedFQDN
			Win32Error		  	  	  		  = $CurrentSMTP.Win32Error

        }
    }
}

function Set-TargetResource
{
    <#
    .SYNOPSIS
        This will set the desired state
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $ID,

        [Boolean]
		$AccessExecute,

		[Int]
		$AccessFlags,

		[Boolean]
		$AccessNoPhysicalDir,

		[Boolean]
		$AccessNoRemoteExecute,

		[Boolean]
		$AccessNoRemoteRead,

		[Boolean]
		$AccessNoRemoteScript,

		[Boolean]
		$AccessNoRemoteWrite,

		[Boolean]
		$AccessRead,

		[Boolean]
		$AccessScript,

		[Boolean]
		$AccessSource,

		[Boolean]
		$AccessSSL,

		[Boolean]
		$AccessSSL128,

		[Int]
		$AccessSSLFlags,

		[Boolean]
		$AccessSSLMapCert,

		[Boolean]
		$AccessSSLNegotiateCert,

		[Boolean]
		$AccessSSLRequireCert,

		[Boolean]
		$AccessWrite,

		[Boolean]
		$AddNoHeaders,

		[Byte[]]
		$AdminACLBin,

		[Boolean]
		$AllowAnonymous,

		[Boolean]
		$AlwaysUseSsl,

		[Boolean]
		$AnonymousOnly,

		[Boolean]
		$AnonymousPasswordSync,

		[String]
		$AnonymousUserName,

		[Boolean]
		$AuthAnonymous,

		[Boolean]
		$AuthBasic,

		[Int]
		$AuthFlags,

		[Boolean]
		$AuthMD5,

		[Boolean]
		$AuthNTLM,

		[Boolean]
		$AuthPassport,

		[Boolean]
		$AzEnable,

		[String]
		$AzScopeName,

		[String]
		$AzStoreName,

		[String]
		$BadMailDirectory,

		[String]
		$Caption,

		[Boolean]
		$ClusterEnabled,

		[Int]
		$ConnectionTimeout,

		[String]
		$ConnectResponse,

		[String]
		$DefaultDomain,

		[String]
		$DefaultLogonDomain,

		[String]
		$Description,

		[Boolean]
		$DisableSocketPooling,

		[Boolean]
		$DoMasquerade,

		[Boolean]
		$DontLog,

		[String]
		$DropDirectory,

		[Boolean]
		$EnableReverseDnsLookup,

		[Int]
		$EtrnDays,

		[Boolean]
		$EtrnSubdomains,

		[String]
		$FullyQualifiedDomainName,

		[Int]
		$HopCount,

		[Boolean]
		$LimitRemoteConnections,

		[Int]
		$LocalRetryAttempts,

		[Int]
		$LocalRetryInterval,

		[Boolean]
		$LogExtFileBytesRecv,

		[Boolean]
		$LogExtFileBytesSent,

		[Boolean]
		$LogExtFileClientIp,

		[Boolean]
		$LogExtFileComputerName,

		[Boolean]
		$LogExtFileCookie,

		[Boolean]
		$LogExtFileDate,

		[Int]
		$LogExtFileFlags,

		[Boolean]
		$LogExtFileHost,

		[Boolean]
		$LogExtFileHttpStatus,

		[Boolean]
		$LogExtFileHttpSubStatus,

		[Boolean]
		$LogExtFileMethod,

		[Boolean]
		$LogExtFileProtocolVersion,

		[Boolean]
		$LogExtFileReferer,

		[Boolean]
		$LogExtFileServerIp,

		[Boolean]
		$LogExtFileServerPort,

		[Boolean]
		$LogExtFileSiteName,

		[Boolean]
		$LogExtFileTime,

		[Boolean]
		$LogExtFileTimeTaken,

		[Boolean]
		$LogExtFileUriQuery,

		[Boolean]
		$LogExtFileUriStem,

		[Boolean]
		$LogExtFileUserAgent,

		[Boolean]
		$LogExtFileUserName,

		[Boolean]
		$LogExtFileWin32Status,

		[String]
		$LogFileDirectory,

		[Int]
		$LogFilePeriod,

		[Int]
		$LogFileTruncateSize,

		[String]
		$LogOdbcDataSource,

		[String]
		$LogOdbcPassword,

		[String]
		$LogOdbcTableName,

		[String]
		$LogOdbcUserName,

		[String]
		$LogPluginClsid,

		[Int]
		$LogType,

		[String]
		$MasqueradeDomain,

		[Int]
		$MaxBandwidth,

		[Int]
		$MaxBatchedMessages,

		[Int]
		$MaxConnections,

		[Int]
		$MaxDirChangeIOSize,

		[Int]
		$MaxEndpointConnections,

		[Int]
		$MaxMailObjects,

		[Int]
		$MaxMessageSize,

		[Int]
		$MaxOutConnections,

		[Int]
		$MaxOutConnectionsPerDomain,

		[Int]
		$MaxRecipients,

		[Int]
		$MaxSessionSize,

		[Int]
		$MaxSmtpErrors,		

		[Int]
		$NameResolutionType,

		[String]
		$NTAuthenticationProviders,

		[String]
		$PickupDirectory,

		[String]
		$QueueDirectory,

		[String]
		$Realm,

		[Int]
		$RelayForAuth,

		[Byte[]]
		$RelayIpList,

		[Int]
		$RemoteRetryAttempts,

		[Int]
		$RemoteRetryInterval,

		[Int]
		$RemoteSmtpPort,

		[Int]
		$RemoteSmtpSecurePort,

		[Int]
		$RemoteTimeout,

		[Int]
		$RouteAction,

		[String]
		$RoutePassword,

		[String]
		$RouteUserName,

		[String]
		$RoutingDll,

		[String]
		$SaslLogonDomain,

		[Object[]]
		$SecureBindings,

		[String]
		$SendBadTo,

		[String]
		$SendNdrTo,

		[Boolean]
		$ServerAutoStart,

		[Object[]]
		$ServerBindings,

		[String]
		$ServerComment,

		[Int]
		$ServerListenBacklog,

		[Int]
		$ServerListenTimeout,

		[String]
		$SettingID,

		[Boolean]
		$ShouldDeliver,

		[Boolean]
		$ShouldPickupMail,

		[Boolean]
		$ShouldPipelineIn,

		[Boolean]
		$ShouldPipelineOut,

		[String]
		$SmartHost,

		[Int]
		$SmartHostType,

		[Int]
		$SmtpAqueueWait,

		[Int]
		$SmtpAuthTimeout,

		[Int]
		$SmtpBdatTimeout,

		[String]
		$SmtpClearTextProvider,

		[Int]
		$SmtpConnectTimeout,

		[Int]
		$SmtpDataTimeout,

		[Boolean]
		$SmtpDisableRelay,

		[Int]
		$SmtpDomainValidationFlags,

		[Boolean]
		$SmtpDotStuffPickupDirFiles,

		[Int]
		$SmtpDSNLanguageID,

		[Int]
		$SmtpDSNOptions,

		[Int]
		$SmtpEventlogLevel,

		[Boolean]
		$SmtpHeloNoDomain,

		[Int]
		$SmtpHeloTimeout,

		[Int]
		$SmtpInboundCommandSupportOptions,

		[Int]
		$SmtpIpRestrictionFlag,

		[Int]
		$SmtpLocalDelayExpireMinutes,

		[Int]
		$SmtpLocalNDRExpireMinutes,

		[Int]
		$SmtpMailFromTimeout,

		[Boolean]
		$SmtpMailNoHelo,

		[Int]
		$SmtpMaxRemoteQThreads,

		[Int]
		$SmtpOutboundCommandSupportOptions,

		[Int]
		$SmtpRcptToTimeout,

		[Int]
		$SmtpRemoteDelayExpireMinutes,

		[Int]
		$SmtpRemoteNDRExpireMinutes,

		[String]
		$SmtpRemoteProgressiveRetry,

		[Int]
		$SmtpRemoteRetryThreshold,

		[Int]
		$SmtpRsetTimeout,

		[Int]
		$SmtpSaslTimeout,

		[Boolean]
		$SmtpSSLCertHostnameValidation,

		[Boolean]
		$SmtpSSLRequireTrustedCA,

		[Int]
		$SmtpTurnTimeout,

		[Int]
		$SmtpUseTcpDns,

		[Boolean]
		$UpdatedDefaultDomain,

		[Boolean]
		$UpdatedFQDN,

		[Int]
		$Win32Error
    )

    Assert-Module
    
    $Result = Get-TargetResource -Name $ID

    # Update Parameters
    foreach ($parameter in $ParameterList.Name)
    {
        if ($PSBoundParameters.ContainsKey($parameter) -and `
            $Result.$parameter -ne $PSBoundParameter.$parameter)
        {
            switch($parameter)
            {
                BadMailDirectory
                {
                    if(-not (Test-Path -Path $BadMailDirectory))
                    {
                        $ErrorMessage = $LocalizedData.ErrorBadMailDirectoryFailure
                        New-TerminatingError -ErrorId 'BadMailDirectoryFailure' `
                                             -ErrorMessage $ErrorMessage `
                                             -ErrorCategory 'InvalidResult'
                    }
                    Write-Verbose -Message ($LocalizedData.VerboseSetTargetBadMailDirectory)
                    Set-SMTPSettings -Name $ID `
                                     -Setting 'BadMailDirectory' `
                                     -Value $BadMailDirectory
                }

                LogFileDirectory
                {
                    if(-not (Test-Path -Path $LogFileDirectory))
                    {
                        $ErrorMessage = $LocalizedData.ErrorLogFileDirectoryFailure
                        New-TerminatingError -ErrorId 'LogFileDirectoryFailure' `
                                                -ErrorMessage $ErrorMessage `
                                                -ErrorCategory 'InvalidResult'
                    }
                    Write-Verbose -Message ($LocalizedData.VerboseSetTargetLogFileDirectory)
                    Set-SMTPSettings -Name $ID `
                                        -Setting 'LogFileDirectory' `
                                        -Value $LogFileDirectory
                }

                SendNdrTo
                {
                    if(Test-EmailAddress -Email $SendNdrTo)
                    {
                        Write-Verbose -Message ($LocalizedData.VerboseSetTargetSendNdrTo)
                        Set-SMTPSettings -Name $ID `
                                         -Setting 'SendNdrTo' `
                                         -Value $SendNdrTo
                    }
                }

                ServerBindings
                {
                    if (Test-SMTPBindings -ServerBindings $ServerBindings)
                    {
                        if (-not(Confirm-UniqueBindings `
                                -ExistingBindings $Result.ServerBindings `
                                -ProposedBindings $ServerBindings ))
                        {
                            Write-Verbose -Message ($LocalizedData.VerboseSetTargetServerBindings)
                            # Make input bindings which are an array, into a string
                            $stringafiedBindings = $ServerBindings -join ' '
                            Set-SMTPSettings -Name $ID `
                                             -Setting 'ServerBindings' `
                                             -Value $stringafiedBindings
                        }
                    }
                }

                Default
                {
                    Write-Verbose -Message ($LocalizedData.VerboseSetTargetResourceUpdated `
                            -f $parameter)
                    Set-SMTPSettings -Name $ID `
                                     -Setting $parameter `
                                     -Value $PSBoundParameters.$parameter
                }
            }
        }
    }
}

function Test-TargetResource
{
    <#
    .SYNOPSIS
        This test the desired state. If the state is not correct it will return $false.
        If the state is correct it will return $true
    #>

    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $ID,

    	[Boolean]
		$AccessExecute,

		[Int]
		$AccessFlags,

		[Boolean]
		$AccessNoPhysicalDir,

		[Boolean]
		$AccessNoRemoteExecute,

		[Boolean]
		$AccessNoRemoteRead,

		[Boolean]
		$AccessNoRemoteScript,

		[Boolean]
		$AccessNoRemoteWrite,

		[Boolean]
		$AccessRead,

		[Boolean]
		$AccessScript,

		[Boolean]
		$AccessSource,

		[Boolean]
		$AccessSSL,

		[Boolean]
		$AccessSSL128,

		[Int]
		$AccessSSLFlags,

		[Boolean]
		$AccessSSLMapCert,

		[Boolean]
		$AccessSSLNegotiateCert,

		[Boolean]
		$AccessSSLRequireCert,

		[Boolean]
		$AccessWrite,

		[Boolean]
		$AddNoHeaders,

		[Byte[]]
		$AdminACLBin,

		[Boolean]
		$AllowAnonymous,

		[Boolean]
		$AlwaysUseSsl,

		[Boolean]
		$AnonymousOnly,

		[Boolean]
		$AnonymousPasswordSync,

		[String]
		$AnonymousUserName,

		[Boolean]
		$AuthAnonymous,

		[Boolean]
		$AuthBasic,

		[Int]
		$AuthFlags,

		[Boolean]
		$AuthMD5,

		[Boolean]
		$AuthNTLM,

		[Boolean]
		$AuthPassport,

		[Boolean]
		$AzEnable,

		[String]
		$AzScopeName,

		[String]
		$AzStoreName,

		[String]
		$BadMailDirectory,

		[String]
		$Caption,

		[Boolean]
		$ClusterEnabled,

		[Int]
		$ConnectionTimeout,

		[String]
		$ConnectResponse,

		[String]
		$DefaultDomain,

		[String]
		$DefaultLogonDomain,

		[String]
		$Description,

		[Boolean]
		$DisableSocketPooling,

		[Boolean]
		$DoMasquerade,

		[Boolean]
		$DontLog,

		[String]
		$DropDirectory,

		[Boolean]
		$EnableReverseDnsLookup,

		[Int]
		$EtrnDays,

		[Boolean]
		$EtrnSubdomains,

		[String]
		$FullyQualifiedDomainName,

		[Int]
		$HopCount,

		[Boolean]
		$LimitRemoteConnections,

		[Int]
		$LocalRetryAttempts,

		[Int]
		$LocalRetryInterval,

		[Boolean]
		$LogExtFileBytesRecv,

		[Boolean]
		$LogExtFileBytesSent,

		[Boolean]
		$LogExtFileClientIp,

		[Boolean]
		$LogExtFileComputerName,

		[Boolean]
		$LogExtFileCookie,

		[Boolean]
		$LogExtFileDate,

		[Int]
		$LogExtFileFlags,

		[Boolean]
		$LogExtFileHost,

		[Boolean]
		$LogExtFileHttpStatus,

		[Boolean]
		$LogExtFileHttpSubStatus,

		[Boolean]
		$LogExtFileMethod,

		[Boolean]
		$LogExtFileProtocolVersion,

		[Boolean]
		$LogExtFileReferer,

		[Boolean]
		$LogExtFileServerIp,

		[Boolean]
		$LogExtFileServerPort,

		[Boolean]
		$LogExtFileSiteName,

		[Boolean]
		$LogExtFileTime,

		[Boolean]
		$LogExtFileTimeTaken,

		[Boolean]
		$LogExtFileUriQuery,

		[Boolean]
		$LogExtFileUriStem,

		[Boolean]
		$LogExtFileUserAgent,

		[Boolean]
		$LogExtFileUserName,

		[Boolean]
		$LogExtFileWin32Status,

		[String]
		$LogFileDirectory,

		[Int]
		$LogFilePeriod,

		[Int]
		$LogFileTruncateSize,

		[String]
		$LogOdbcDataSource,

		[String]
		$LogOdbcPassword,

		[String]
		$LogOdbcTableName,

		[String]
		$LogOdbcUserName,

		[String]
		$LogPluginClsid,

		[Int]
		$LogType,

		[String]
		$MasqueradeDomain,

		[Int]
		$MaxBandwidth,

		[Int]
		$MaxBatchedMessages,

		[Int]
		$MaxConnections,

		[Int]
		$MaxDirChangeIOSize,

		[Int]
		$MaxEndpointConnections,

		[Int]
		$MaxMailObjects,

		[Int]
		$MaxMessageSize,

		[Int]
		$MaxOutConnections,

		[Int]
		$MaxOutConnectionsPerDomain,

		[Int]
		$MaxRecipients,

		[Int]
		$MaxSessionSize,

		[Int]
		$MaxSmtpErrors,		

		[Int]
		$NameResolutionType,

		[String]
		$NTAuthenticationProviders,

		[String]
		$PickupDirectory,

		[String]
		$QueueDirectory,

		[String]
		$Realm,

		[Int]
		$RelayForAuth,

		[Byte[]]
		$RelayIpList,

		[Int]
		$RemoteRetryAttempts,

		[Int]
		$RemoteRetryInterval,

		[Int]
		$RemoteSmtpPort,

		[Int]
		$RemoteSmtpSecurePort,

		[Int]
		$RemoteTimeout,

		[Int]
		$RouteAction,

		[String]
		$RoutePassword,

		[String]
		$RouteUserName,

		[String]
		$RoutingDll,

		[String]
		$SaslLogonDomain,

		[Object[]]
		$SecureBindings,

		[String]
		$SendBadTo,

		[String]
		$SendNdrTo,

		[Boolean]
		$ServerAutoStart,

		[Object[]]
		$ServerBindings,

		[String]
		$ServerComment,

		[Int]
		$ServerListenBacklog,

		[Int]
		$ServerListenTimeout,

		[String]
		$SettingID,

		[Boolean]
		$ShouldDeliver,

		[Boolean]
		$ShouldPickupMail,

		[Boolean]
		$ShouldPipelineIn,

		[Boolean]
		$ShouldPipelineOut,

		[String]
		$SmartHost,

		[Int]
		$SmartHostType,

		[Int]
		$SmtpAqueueWait,

		[Int]
		$SmtpAuthTimeout,

		[Int]
		$SmtpBdatTimeout,

		[String]
		$SmtpClearTextProvider,

		[Int]
		$SmtpConnectTimeout,

		[Int]
		$SmtpDataTimeout,

		[Boolean]
		$SmtpDisableRelay,

		[Int]
		$SmtpDomainValidationFlags,

		[Boolean]
		$SmtpDotStuffPickupDirFiles,

		[Int]
		$SmtpDSNLanguageID,

		[Int]
		$SmtpDSNOptions,

		[Int]
		$SmtpEventlogLevel,

		[Boolean]
		$SmtpHeloNoDomain,

		[Int]
		$SmtpHeloTimeout,

		[Int]
		$SmtpInboundCommandSupportOptions,

		[Int]
		$SmtpIpRestrictionFlag,

		[Int]
		$SmtpLocalDelayExpireMinutes,

		[Int]
		$SmtpLocalNDRExpireMinutes,

		[Int]
		$SmtpMailFromTimeout,

		[Boolean]
		$SmtpMailNoHelo,

		[Int]
		$SmtpMaxRemoteQThreads,

		[Int]
		$SmtpOutboundCommandSupportOptions,

		[Int]
		$SmtpRcptToTimeout,

		[Int]
		$SmtpRemoteDelayExpireMinutes,

		[Int]
		$SmtpRemoteNDRExpireMinutes,

		[String]
		$SmtpRemoteProgressiveRetry,

		[Int]
		$SmtpRemoteRetryThreshold,

		[Int]
		$SmtpRsetTimeout,

		[Int]
		$SmtpSaslTimeout,

		[Boolean]
		$SmtpSSLCertHostnameValidation,

		[Boolean]
		$SmtpSSLRequireTrustedCA,

		[Int]
		$SmtpTurnTimeout,

		[Int]
		$SmtpUseTcpDns,

		[Boolean]
		$UpdatedDefaultDomain,

		[Boolean]
		$UpdatedFQDN,

		[Int]
		$Win32Error
    )
    
    Assert-Module
    
    # Throw if SMTP not found
    if (-not (Get-SMTPSettings -ID $ID))
        {
            $ErrorMessage = $LocalizedData.ErrorSMTPDiscoveryFailure
            New-TerminatingError -ErrorId 'SMTPDiscoveryFailure' `
                                 -ErrorMessage $ErrorMessage `
                                 -ErrorCategory 'InvalidResult'
        }
        
    $Result = Get-TargetResource -Name $ID

    foreach ($parameter in $ParameterList.Name)
    {
        if ($PSBoundParameters.ContainsKey($parameter) -and `
            $Result.$parameter -ne $PSBoundParameter.$parameter)
        {
            switch($parameter)
            {
                BadMailDirectory
                {
                    if(-not (Test-Path -Path $BadMailDirectory))
                    {
                        $ErrorMessage = $LocalizedData.ErrorBadMailDirectoryFailure
                        New-TerminatingError -ErrorId 'BadMailDirectoryFailure' `
                                             -ErrorMessage $ErrorMessage `
                                             -ErrorCategory 'InvalidResult'
                    }
                    Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseBadMailDirectory)
                    return $False
                }

                LogFileDirectory
                {
                    if(-not (Test-Path -Path $LogFileDirectory))
                    {
                        $ErrorMessage = $LocalizedData.ErrorLogFileDirectoryFailure
                        New-TerminatingError -ErrorId 'LogFileDirectoryFailure' `
                                             -ErrorMessage $ErrorMessage `
                                             -ErrorCategory 'InvalidResult'
                    }
                    Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseLogFileDirectory)
                    return $False
                }

                SendNdrTo
                {
                    if(Test-EmailAddress -Email $SendNdrTo)
                    {
                        Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseSendNdrTo)
                        return $False
                    }
                }

                ServerBindings
                {
                    # Test if the desired IP and/or port input is valid
                    if (-not (Test-SMTPBindings -ServerBindings $ServerBindings))
                    {
                        Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseServerBindings)
                        return $False
                    }
        
                    # Test if the bindings are different
                    if (-not(Confirm-UniqueBindings `
                                -ExistingBindings $Result.ServerBindings `
                                -ProposedBindings $ServerBindings ))
                    {
                        Write-Verbose -Message ($LocalizedData.VerboseTestTargetFalseServerBindings)
                        return $False
                    }
                }

                Default
                {
                    Write-Verbose -Message ($LocalizedData.VerboseTestTargetResource `
                                    -f $parameter)
                    return $False
                }
            }
        }
    }
    return $true
}

#region Helper Functions

Function Confirm-UniqueBindings
{
    <#
    .SYNOPSIS
        Helper function used to validate that the SMTP's binding information is unique.
        Returns False if bindings are not unique and True if they are
    .PARAMETER ExistingBindings
        Specifies existing SMTP bindings
    .PARAMETER ProposedBindings
        Specifies desired SMTP bindings.
    .NOTES
        The existing bindings are a [String] where are the desired are a [Array] so we 
        need to do some magic to make sure the compare works.
    #>

    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    ( 
        [Parameter(Mandatory = $true)]
        [String] $ExistingBindings,
        
        [Parameter(Mandatory = $true)]
        [String[]]  $ProposedBindings
    )

    $InputToCheck = @()
    foreach($ProposedBinding in $ProposedBindings)
    { 
        $BindingAddition = $ProposedBinding + ':'
        $InputToCheck += $BindingAddition
    }

    $ExistingBindingsToCheck = $ExistingBindings -split '\n'

    $ExistingToCheck = @()
    foreach($ExistingBinding in $ExistingBindingsToCheck)
    {
        $ExistingToCheck += $ExistingBinding.Trim()
    }

    $SortedExistingBindings = $ExistingToCheck | Sort-Object -Unique
    $SortedInputBindings = $InputToCheck| Sort-Object -Unique


    if (Compare-Object -ReferenceObject $SortedExistingBindings `
                       -DifferenceObject $SortedInputBindings `
                       -PassThru)
    {
        return $false
    }

    return $true
}

Function Get-SMTPSettings
{
    <#
    .SYNOPSIS
        Helper function used to get the SMTP server.
    .PARAMETER ID
        Specifies the ID of the SMTP virtual server. 1 is the default SMTP server.
    .NOTES
        All it does is wrap a [ASDI] call
    #>

    [CmdletBinding()]
    param
    ( 
        [Parameter(Mandatory = $true)]
        [String] $ID
    )

    return  Get-WmiObject IISSmtpServerSetting -namespace "ROOT\MicrosoftIISv2" | Where-Object { $_.name -like "SmtpSVC/${ID}" }
}

Function Set-SMTPSettings
{
    <#
    .SYNOPSIS
        Helper function used to set the SMTP server settings.
    .PARAMETER ID
        Specifies the ID of the SMTP virtual server. 1 is the default SMTP server.
    .PARAMETER Setting
        Specifies the setting of the SMTP virtual server to be changed.
    .PARAMETER Value
        Specifies the value of the SMTP virtual server setting to be changed.
    .NOTES
        All it does is wrap a [ASDI] call. Also this is used to allow pester to mock this call
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $Name,
        
        [Parameter(Mandatory = $true)]
        [String] $Setting,
        
        [Parameter(Mandatory = $true)]
        [String] $Value
    )
    
    $SMTPSite = Get-WmiObject IISSmtpServerSetting -namespace "ROOT\MicrosoftIISv2" | Where-Object { $_.name -like "SmtpSVC/${Name}" }
    $SMTPSite.$Setting=$Value
    $SMTPSite.Put()
}

Function Test-EmailAddress
{
    <#
    .SYNOPSIS
        Tests that an email address is valid when used as input.
    .PARAMETER Email
        Specifies the  desired email address.
    .NOTES
        Simple function which casts an email address to [Net.Mail.MailAddress] to see if it 
        is valid are not. If not valid it will error, if vaild will return True
    #>

    [CmdletBinding()]
    param
    (
        [OutputType([Boolean])]
        [Parameter(Mandatory = $true)]
        [String] $Email
    )
    
    if($Email)
    {
        if (-not($Email -as [Net.Mail.MailAddress]))
        {
            $ErrorMessage = $LocalizedData.ErrorEmailAddressFailure
            New-TerminatingError -ErrorId 'EmailAddressFailure' `
                                    -ErrorMessage $ErrorMessage `
                                    -ErrorCategory 'InvalidResult'
        }
    }
    
    return $true
}

Function Test-SMTPBindings
{
    <#
    .SYNOPSIS
        Tests that an server bindings are valid when used as input.
    .PARAMETER ServerBindings
        Specifies the  desired server bindings.
    .NOTES
        Simple function which casts an IP  address to [ipaddress] to see if it 
        is valid are not. If not valid it will error, if vaild will return True.
        Does the same for the port but uses regex to check if valid in the correct
        port range.
    #>

    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String[]] $ServerBindings
    )

    foreach ($Binding in $ServerBindings)

    {
        $IP = ($Binding -split ':')[0]
        $Port = ($Binding -split ':')[1]

        if($IP)
        {
            if (-not($IP -as [ipaddress]))
            {
                $ErrorMessage = $LocalizedData.ErrorIPAddressFailure
                New-TerminatingError -ErrorId 'IPAddressFailure' `
                                     -ErrorMessage $ErrorMessage `
                                     -ErrorCategory 'InvalidResult'
            }
        }

        if($Port)
        {
            if (-not($Port -match `
                    '^(6553[0-5]|655[0-2]\d|65[0-4]\d\d|6[0-4]\d{3}|[1-5]\d{4}|[1-9]\d{0,3}|0)$')
                    )
            {
                $ErrorMessage = $LocalizedData.ErrorBindingsPortFailure
                New-TerminatingError -ErrorId 'BindingsPortFailure' `
                                     -ErrorMessage $ErrorMessage `
                                     -ErrorCategory 'InvalidResult'
            }
        }
    }
    
    return $true
}

#endregion

Export-ModuleMember -Function *-TargetResource
