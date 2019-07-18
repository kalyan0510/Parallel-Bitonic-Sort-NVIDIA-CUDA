**READ ME**


In detail document: 
https://docs.google.com/document/d/e/2PACX-1vR4oP3_WhNM-sgOSx4_VIAJU0iqe1zTZdnnFqqJXM8DGCo-udl8aYzUBMs/pub


Before we start setup first we need to make sure

1. 1)that the computer you are on has a supported GPU
2. 2)To check the GPU model in a lab computer, open the NVIDIA Control Panel. The GPU model is shown on the initial screen

Setup on Windows

1. Make sure you are running Windows 7/8/10 and that your NVIDIA drivers are up-to-date
2. Install Visual Studio 2015
3. You need C++ support. None of the optional components are necessary. Install [CUDA 7](https://developer.nvidia.com/cuda-downloads?sid=925343). CUDA 7.5 is recommended for its new performance profiling tools. However, 7.0 is fine
4. Use the Express installation. If using Custom, make sure you select Nsight for Visual Studio.
5. Download the VS  2015 project from github and click on Bitonic.vcxproj to open it in VS 2015.
6. Run the code to get Analysis which looks like below:

AnalysisReport:

    N       time over        time over      is sorted?    speedup
         serial code      Bitonic CUDA code

      4      0.00000          0.00000          YES     0.000000

      8      0.00000          0.00000          YES     0.000000

     16      0.00000          0.00000          YES     0.000000

     32      0.00000          0.00000          YES     0.000000

     64      0.00000          0.00000          YES     0.000000

    128      0.00000          0.00100          YES     0.000000

    256      0.00000          0.00000          YES     0.000000

    512      0.00000          0.00100          YES     1.000000

    1024      0.00100          0.00100          YES     0.999999

    2048      0.00100          0.00100          YES     0.999999

    4096      0.00300          0.00100          YES     2.999997

    8192      0.00700          0.00300          YES     2.333333

    16384      0.01300          0.00400          YES     3.249999

    32768      0.02700          0.00900          YES     3.000000

    65536      0.04400          0.01700          YES     2.588235

    131072      0.10400          0.03900          YES     2.666667

    262144      0.18100          0.08400          YES     2.154762

    524288      0.35000          0.17400          YES     2.011494






[Source](https://docs.google.com/document/d/e/2PACX-1vR4oP3_WhNM-sgOSx4_VIAJU0iqe1zTZdnnFqqJXM8DGCo-udl8aYzUBMs/pub "Permalink to BitonicSortingonGPU.docx")

# BitonicSortingonGPU.docx

Parallel Computing                                                                                    kalyan 140001011

Optimized Bitonic Sort on Graphic Processor

![][1]

Introduction

 Sorting is a popular Computer Science topic which receives much attention. Many sequential sorts take O(NlogN) time to sort N keys. Bitonic sort is based on repeatedly merging two bitonic sequences to form a larger bitonic sequence and takes only O(Nlog2N) time steps.

Objective

  Our objective here is to implement the bitonic sorting network in a Graphical processing Unit and analysing its performance when compared to a sequential sorting method. 

Bitonic Sequence

 A bitonic sequence is a sequence with x0 ≤ . . . ≤ xk ≥ . . . xn-1 for some k, 0≤k[capture.png][2]                                  sorting network for n numbers consists lg stages, where i-th stage composed increasing and decreasing merges 2i. each node identified by three integers  the stage, column inside row node. will see how use this structure our cuda code. looks like this:    ![capture1.png][3] here four stages having variable (#columns="stage" no.) no. columns. 2 comparisons. need processors to run algorithm parallely. merge sort (array) build 4 i.e., small way array splits into double size. every step doubles. if  for log2(n) times becomes 2n with its pivot end array, values from beginning  are order, sorted.![capture.png][2]  if figure (to right), merging (with center) needs steps. divided half length finally gets  sorted graphics processor![capture2.png][4] gpu parallel processor, their highly makes them more efficient general-purpose cpus algorithms processing large blocks data done parallel. gpu's contains multiprocessors m cores each. same processor share instruction they simd nvidia (compute unified device architecture) language developed general purpose computing. have deal both host memory (primary memory) (gpu's memory). has own thread layout be defined programmer. threads organised these form grid. block executed multiprocessor. only kernel functions gpu. implementation let us say index starting 0 2-1. actually problem easily implemented recursively, but not method, instead mapping (optimized )where map what g and t let's index, then g positions m1 m2 :                 m1="map"                 m2="map" + (2(t - 1))                                where 1)))*(2t) (index % 1))) dir="        (map" (2g))                  dir defines bigger value after swapping         since code it function, mentioned below:          

Click here: 
https://docs.google.com/document/d/e/2PACX-1vR4oP3_WhNM-sgOSx4_VIAJU0iqe1zTZdnnFqqJXM8DGCo-udl8aYzUBMs/pub for the rest of the document





[1]: https://lh3.googleusercontent.com/6jIgnhtbZruIQWIKASa1x3lw9ayoO1M1Bferw48tA4Ant5V1PXhT18SVhaC5e5euqFwnqF1EqwztI-QGXgvnIvXHfheaYuL4Izn9pyCNwucjuIeaW7HO5FFJjOo "horizontal line"
[2]: https://lh3.googleusercontent.com/UFhq3eNWs03toAwtoBdpY_1Ajj2SGowxnS1xuBQw9yI1uy3E0yruQ9ohXDt6dJL8Z3npXGHnhrdaTJNwSXgVBBw4H_JY_8AwwnzXw0dsMEtUXa6g7RdbRD9BZQw
[3]: https://lh3.googleusercontent.com/PlnpHiCG78bBKmOUpd_xLOI4uAPZ1WfJpr7pqz5YXZul83XKgKgPeuL9YXdTz54mpfMB072U6h9H_-PS3zRvE7GcoCwjC1aMKH1MqNUdUAvecL8mWcdTYCFHl8U
[4]: https://lh4.googleusercontent.com/nlCLuyqTnp5aT5zKmpyggo2EiKYBD-61cDv7FDNlF8YAh31bwe5MNPcIIdflrq7uVNB6neNcMfKgbEcCjmX3EM6KUQQVZFo7jJvs4qBU2VZd1ETV2fHMn8KfbSg
[5]: https://lh3.googleusercontent.com/0FzuZ0wRleGFxe5jUna25IAzX5obE9NFky2s95Ml7-YvPC3RCYg5FwbHRTWLNmsoVU4iYL8t0cdmHX0P1YYql_sa8PohRydjxvluxwcQYE4ueAiGj3me8leU31I "horizontal line"

  

Enter a string or /regular expression/
