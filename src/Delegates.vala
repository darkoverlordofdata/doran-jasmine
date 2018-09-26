using System;
using System.Collections.Generic;
/**
 * Jasmine (https://jasmine.github.io/) inspired BDD Testing
 *
 */
namespace Jasmine
{

    public delegate void OnCompleteDelegate();
    public delegate void Callback();
	[CCode (has_target = false)]
    public delegate bool Filter();

    internal class CallbackWrapper
    {
        Callback callback;
        public CallbackWrapper(Callback callback)
        {
            this.callback = callback;
        }
    }

    internal CallbackWrapper Wrapper(Callback callback)
    {
        return new CallbackWrapper(callback);
    }
}