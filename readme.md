# jasmine

Port of [jasmine](https://github.com/jasmine/jasmine.github.io) 1.3.1




```vala
namespace Demo
{
    using System;
    using Jasmine;

    public class Program
    {
        public static void main (string[] args) 
        {
            print("Hello World\n");
            test();
        }

        public void test()
        {
            Describe("running jasmine in vala", () => {
                It("should run tests", () => {
                    Expect<bool>(true).ToBe<bool>(true);
                });
            });

            var env = Jasmine.GetEnv();
            env.AddReporter(new Jasmine.ConsoleReporter());
            env.Execute();

        }
    }


}
```