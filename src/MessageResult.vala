using System;
using System.Collections.Generic;

public class Jasmine.MessageResult : Resultable
{
    private string format;
    // private va_list values;
    private string type;
    private bool passed;
    // public ArrayList<NestedResults> Items;

    // public MessageResult(string format, va_list values, bool passed = true, string resulttype = "log")
    public MessageResult(string format, bool passed = true, string resulttype = "log")
    {
        this.format = format;
        // Values = values;
        this.passed = passed;
        this.type = resulttype;
    }

}

