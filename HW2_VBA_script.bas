

' Homework 2 VBA assignment for UC Davis bootcamp
' George Bigham


Sub sumerizeStocks()

' WARNING: the following routine requires presorting by ticker and date

' rown is an iterator for representing row number
Dim rown As Double

' tickern tracks number of tickers
Dim tickern As Integer
Dim ticker_rown As Integer

' ticker is a place holder for specific tickers
Dim ticker As String

Dim volume As Double
Dim opening As Double
Dim closing As Double

Dim greatestpinc As Double
Dim greatestpdec As Double
Dim greatesttotvol As Double

' Initializing variables, starts at row 2
rown = 2
ticker = Cells(2, 1).Value
tickern = 2
opening = Cells(2, 3).Value
volume = 0
ticker_rown = 2
greatestpinc = 0
greatestpdec = 0
greatesttotvol = 0

Do While Not IsEmpty(Cells(rown, 1))

    Dim yrchange As Double
    
    ' If the ticker is name is the same, add volume to total
    If ticker = Cells(rown, 1) Then
        volume = volume + Cells(rown, 7).Value

   ' If there is a new ticker, do the following
    Else
        ' finalize closing and enter final values for old ticker
        closing = Cells(rown - 1, 6)
        yrchange = closing - opening
        Cells(tickern, 10).Value = yrchange
        
        ' avoid dividing by zero when calculating percent change
        ' note: percent change for stock starting year are set to zero
        If opening <> 0 Then
            Cells(tickern, 11).Value = yrchange / opening
        Else
            Cells(tickern, 11).Value = 0
        End If
        
        Cells(tickern, 12).Value = volume
        Cells(tickern, 9).Value = ticker
                    
        ' iterate tickern and reset new ticker and opening
        tickern = tickern + 1
        ticker = Cells(rown, 1)
        opening = Cells(rown, 3)
        volume = 0

    End If
    
    rown = rown + 1

Loop

' Second while loop formats and summarize greatest values
Do While Not IsEmpty(Cells(ticker_rown, 9))

    Cells(ticker_rown, 11).NumberFormat = "0.00%"

    If Cells(ticker_rown, 10).Value < 0 Then
        Cells(ticker_rown, 10).Interior.ColorIndex = 3
    Else
        Cells(ticker_rown, 10).Interior.ColorIndex = 4
    End If

    If Cells(ticker_rown, 11).Value > greatestpinc Then
        Range("P2") = Cells(ticker_rown, 9)
        greatestpinc = Cells(ticker_rown, 11)
        Range("Q2") = greatestpinc
    End If
    
    If Cells(ticker_rown, 11).Value < greatestpdec Then
        Range("P3") = Cells(ticker_rown, 9)
        greatestpdec = Cells(ticker_rown, 11)
        Range("Q3") = greatestpdec
    End If
    
    If Cells(ticker_rown, 12).Value > greatesttotvol Then
        Range("P4") = Cells(ticker_rown, 9)
        greatesttotvol = Cells(ticker_rown, 12)
        Range("Q4") = greatesttotvol
    End If
        
    ticker_rown = ticker_rown + 1

Loop


' Fill variable titles names
Range("I1").Value = "Ticker"
Range("J1").Value = "Yearly Change"
Range("K1").Value = "Percent Change"
Range("L1").Value = "Total Stock Volume"
Range("P1").Value = "Ticker"
Range("Q1").Value = "Value"
Range("O2").Value = "Greast % Increase"
Range("O3").Value = "Greast % Decrease"
Range("O4").Value = "Greast Total Volume"

' Formating
Range("Q2:Q3").NumberFormat = "0.00%"

End Sub

