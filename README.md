**READ ME**

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
