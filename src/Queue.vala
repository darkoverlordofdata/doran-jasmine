using System;
using System.Collections.Generic;

public class Jasmine.Queue : Object
{
    private Env env;
    // parallel to blocks. each true value in this array means the block will
    // get executed even if we abort
    private ArrayList<bool> ensured;
    internal ArrayList<Executable> blocks;
    private int index = 0;
    private int offset = 0;
    private bool abort = false;
    private bool running = false;
    private static bool LOOP_DONT_RECURSE = true;
    private bool calledSynchronously = true;
    private bool completedSynchronously = false;
    private bool goAgain = true;
    private OnCompleteDelegate onComplete;


    public Queue(Env env)
    {
        this.env = env;
        this.ensured = new ArrayList<bool>();
        this.blocks = new ArrayList<Executable>();
    }

    public void Copy(Queue other)
    {
        for (var i=0; i<other.blocks.Count; i++)
        {
            Add(other.blocks[i], other.ensured[i]);
        }
    }

    public void AddBefore(Executable block, bool ensure = false)
    {
        blocks.Insert(0, block);
        ensured.Insert(0, ensure);
    }

    public void Add(Executable block, bool ensure = false)
    {
        blocks.Add(block);
        ensured.Add(ensure);
    }

    public void InsertNext(Executable block, bool ensure = false)
    {
        blocks.Insert(offset, block);
        ensured.Insert(offset, ensure);
        offset++;
    }

    public void Start(OnCompleteDelegate onComplete)
    {
        this.onComplete = onComplete;
        running = true;
        Next();
    }
    
    public bool IsRunning() {
        return running;
    }

    public void OnComplete()
    {
        if (LOOP_DONT_RECURSE && calledSynchronously) {
            completedSynchronously = true;
            return;
        }
        
        if (blocks[index].abort) {
            abort = true;
        }

        offset = 0;
        index++;

        if (LOOP_DONT_RECURSE && completedSynchronously) {
            goAgain = true;
        } else {
            Next();
        }

    }
    private void Next()
    {
        if (blocks.Count == 0) {
            running = false;
            return;
        }
        goAgain = true;
        while (goAgain)
        {
            goAgain = false;
            if (index < blocks.Count && !(abort && !ensured[index]))
            {
                calledSynchronously = true;
                completedSynchronously = false;

                GetEnv().currentSpec = ((Block)blocks[index]).GetSpec();
                print("%s\t\t", ((Block)blocks[index]).GetSpec().GetFullName());
                blocks[index].Execute(OnComplete);

                calledSynchronously = false;
                if (completedSynchronously) {
                    OnComplete();
                }
            } else {
                running = false;
            }
        }
    }

    public NestedResults Results()
    {
        var results = new NestedResults();
        for (var i = 0; i < blocks.Count; i++) {
            if (blocks[i] is Suite) {
                results.AddResult(blocks[i].Results());
            }
        }
        return results;
    }
}