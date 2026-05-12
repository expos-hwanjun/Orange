object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 299
  Width = 306
  object UniConnection: TUniConnection
    ProviderName = 'MySQL'
    Port = 8307
    Database = 'orangepos'
    SpecificOptions.Strings = (
      'SQL Server.Provider=prSQL'
      'MySQL.ConnectionTimeout=10')
    Options.ConvertEOL = True
    Options.DisconnectedMode = True
    PoolingOptions.MaxPoolSize = 1000
    Pooling = True
    Username = 'expos'
    Server = '219.250.99.244'
    LoginPrompt = False
    Left = 32
    Top = 24
    EncryptedPassword = '9AFF87FF8FFF90FF8CFFCBFFCEFFC8FFCEFFDEFFBFFFDCFFDBFF'
  end
  object UniQuery: TUniQuery
    Connection = UniConnection
    Left = 112
    Top = 88
  end
  object UPSSConnection: TUniConnection
    ProviderName = 'Access'
    Database = 'C:\Program Files\UPSS\DGPR.mdb'
    LoginPrompt = False
    Left = 192
    Top = 32
    EncryptedPassword = '8FFF9DFFC9FFCCFFCEFFCDFF'
  end
  object UPSSQuery: TUniQuery
    Connection = UPSSConnection
    Left = 248
    Top = 32
  end
  object Script: TUniScript
    Connection = UniConnection
    Left = 32
    Top = 80
  end
  object StoredProc: TUniStoredProc
    Connection = UniConnection
    Left = 24
    Top = 160
  end
  object Query: TUniQuery
    Connection = UniConnection
    Left = 112
    Top = 32
  end
  object CloudData: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 104
    Top = 168
  end
  object SQL: TUniSQL
    Connection = UniConnection
    Left = 200
    Top = 176
  end
  object QueryEx: TUniQuery
    Connection = UniConnection
    Left = 176
    Top = 104
  end
end
