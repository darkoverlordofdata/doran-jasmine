using System;
using System.Collections.Generic;

/**
 * Holds results for a set of Jasmine spec. Allows for the results array to hold another jasmine.NestedResults
 *
 * @constructor
 */
public class Jasmine.NestedResults : Resultable
{
    public NestedResults()
    {
        totalCount = 0;
        passedCount = 0;
        failedCount = 0;
        skipped = false;
        items = new ArrayList<Resultable>();
    }


    /**
     * Adds a log message.
     * @param values Array of message parts which will be concatenated later.
     */
    // public void Log(string format, va_list args)
    // {
    //     items.Add(new MessageResult(format, args, Passed(), "log"));
    // }

    /**
     * Getter for the results: message & results.
     */
    public ArrayList<Resultable> GetItems()
    {
        return items;
    }

    /**
     * Adds a result, tracking counts (total, passed, & failed)
     * @param {jasmine.ExpectationResult|jasmine.NestedResults} result
     */
    public void AddResult(Resultable result)
    {
        if (result.type != "log") {
            if (result.items.Count > 0) {
                RollupCounts(result);
            } else {
                totalCount++;
                if (result.Passed()) {
                    passedCount++;
                } else {
                    failedCount++;
                }
            }
        }
        items.Add(result);
    }


}