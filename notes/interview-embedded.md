Embedded C interview questions and answers
==========================================

BY AMLENDRAON

You are looking for embedded c interview questions or tricky embedded c
interview questions, then you are at the right place. In my previous
post, I have created a collection of “C interview questions” that is
liked by many people. I have got the response to create a list of
interview questions on “embedded c”. So here I have tried to create some
collection of embedded c interview questions that might ask by your
interviewer. These embedded C interview questions, I have created after
spent many hours. I have also given some unsolved embedded system
questions for you at the last of the article. I hope these embedded C
interview questions will be helpful.

And

[/r/embedded]

Q) What is the volatile keyword?
--------------------------------

The volatile keyword is a type qualifier that prevents the objects from
the compiler optimization. According to C standard, an object that has
volatile-qualified type may be modified in ways unknown to the
implementation or have other unknown side effects. You can also say that
the value of the volatile-qualified object can be changed at any time
without any action being taken by the code. If an object is qualified by
the volatile qualifier, the compiler reloads the value from memory each
time it is accessed by the program that means it prevents from cache a
variable into a register. Reading the value from memory is the only way
to check the unpredictable change of the value.

Q) What is the use of volatile keyword?
---------------------------------------

The volatile keyword is mainly used where we directly deal with GPIO,
interrupt or flag Register. It is also used with a global variable or
buffer which shared between the threads.

Q) What is the difference between the const and volatile qualifiers in C?
-------------------------------------------------------------------------

The const keyword is compiler-enforced and says that the program could
not change the value of the object that means it makes the object
nonmodifiable type. Let us see an example,

``` c
  const int a = 0;
```

If we will try to modify the value of “a”, we will get the compiler
error because “a” is qualified with const keyword that prevents to
change the value of the”a” (integer variable).

Another side, volatile prevents any compiler optimization and says that
the value of the object can be changed by something that is beyond the
control of the program and so that compiler will not make any assumption
about the object. Let see an example,

``` c
  volatile int a;
```

When the compiler sees the above declaration then it avoids to make any
assumption regarding the “a” and in every iteration read the value from
the address which is assigned to the “a”.

Q) Can a variable be both constant and volatile in C?
-----------------------------------------------------

Yes, we can use both constant and volatile together. One of the great
use of volatile and const keyword together is at the time of accessing
the GPIO registers. In the case of GPIO, its value will be changed by
the ‘external factors’ (if a switch or any output device is attached
with GPIO), if it is configured as an input. In that situation, volatile
plays an important role and ensures that the compiler always read the
value from the GPIO address and avoid to make any assumption.

After using the volatile keyword, you will get the proper value whenever
you are accessing the ports but still here is one more problem because
the pointer is not const type so it might be your program change the
pointing address of the pointer. So we have to create a constant pointer
with a volatile keyword.

Syntax of declaration,

      int volatile * const PortRegister;

How to read the above declaration,

      int volatile * const PortRegister;

PortRegister is a constant pointer to a volatile integer

Q) Can we have a volatile pointer?
----------------------------------

Yes, we can create a volatile pointer in C language.

      // piData is a volatile pointer to an integer.
      int * volatile piData;

Q) The Proper place to use the volatile keyword?
------------------------------------------------

A volatile is an important qualifier in C programming. Here I am
pointing some places where we need to use the volatile keyword.

Accessing the memory-mapped peripherals register or hardware status
register.

``` c
  #define COM_STATUS_BIT 0x00000006
  uint32_t const volatile
  * const pStatusReg = (uint32_t *)0x00020000;
  unit32_t GetRecvData() {
  	unit32\_t RecvData;

    //Code to receive data
    while (((*pStatusReg)  & COM_STATUS_BIT) == 0)
    {
        // Wait until flag does not set
        //Received data in RecvData
    }
    return RecvData;
  }
```

Sharing the global variables or buffers between the multiple threads.
Accessing the global variables in an interrupt routine or signal
handler.

``` c
  volatile int giFlag = 0;
  ISR(void) { giFlag = 1; }
  int main(void) {
  	while (\!giFlag) {
  		//do some work
  	}
  return 0;
  }
```

Q) What is ISR?
---------------

An ISR refers to the Interrupt Service Routines. These are procedures
stored at specific memory addresses which are called when a certain type
of interrupt occurs. The Cortex-M processors family has the NVIC that
manages the execution of the interrupt.

Q) Where does the interrupt table reside in the memory map for various
----------------------------------------------------------------------

processor families?

Q) Can we pass any parameter and return a value from the ISR?
-------------------------------------------------------------

An ISR returns nothing and not allow to pass any parameter. An ISR is
called when a hardware or software event occurs, it is not called by the
code, so that’s the reason no parameters are passed into an ISR.

In the above line, we have already read that the ISR is not called by
the code, so there is no calling code to read the returned values of the
ISR. It is the reason that an ISR is not returned any value.

Q) What is interrupt latency?
-----------------------------

It is an important question that is asked by the interviewer to test the
understanding of Interrupt. Basically, interrupt latency is the number
of clock cycles that are taken by the processor to respond to an
interrupt request. This number of the clock cycle is count between the
assertions of the interrupt request and the first instruction of the
interrupt handler.

Interrupt Latency on the Cortex-M processor family

The Cortex-M processors have very low interrupt latency. In the below
table, I have mentioned, Interrupt latency of Cortex-M processors with
zero wait state memory systems.

Processors Cycles with zero wait state memory

Cortex-M0 16 Cortex-M0+ 15 Cortex-M3 12 Cortex-M4 12 Cortex-M7 12

Q) How do you measure interrupt latency?
----------------------------------------

With the help of the oscilloscope, we can measure the interrupt latency.
You need to take the following steps.

First takes two GPIOs. Configure one GPIO to generate the interrupt and
second for the toggling (if you want you can attach an LED). Monitor the
PIN (using the oscilloscope or analyzer) which you have configured to
generate the interrupt. Also, monitor (using the oscilloscope or
analyzer) the second pin which is toggled at the beginning of the
interrupt service routine. When you will generate the interrupt then the
signal of both GPIOs will change. The interval between the two signals
(interrupt latency) may be easily read from the instrument.

Q) How to reduce interrupt latency?
-----------------------------------

The interrupt latency depends on many factors, some factors I am
mentioning in the below statements.

Platform and interrupt controller. CPU clock speed. Timer frequency
Cache configuration. Application program. So using the proper selection
of platform and processor we can easily reduce the interrupt latency. We
can also reduce the interrupt latency by making the ISR shorter and
avoid to calling a function within the ISR.

Q) What is the difference between an uninitialized pointer and a null pointer?
------------------------------------------------------------------------------

An uninitialized pointer is a pointer that points unknown memory
location. The behavior of the uninitialized pointer is undefined. If you
try to dereference the uninitialized pointer code behavior will
undefine.

According to C standard, an integer constant expression with the value
0, or such an expression cast to type `void *`, is called a null pointer
constant. The behavior of the uninitialized pointer is defined. When you
try to dereference the null pointer then your code will crash.

Q) What are the causes of Interrupt Latency?
--------------------------------------------

The first delay is typically caused by hardware: The interrupt request
signal needs to be synchronized to the CPU clock. Depending on the
synchronization logic, up to 3 CPU cycles may expire before the
interrupt request has reached the CPU core. The CPU will typically
complete the current instruction, which may take several cycles. On most
systems, divide, push-multiple or memory-copy instructions are the most
time-consuming instructions to execute. On top of the cycles required by
the CPU, additional cycles are often required for memory accesses. In an
ARM7 system, the instruction STMDB SP!,{R0-R11, LR} typically is the
worst-case instruction, storing 13 registers of 32-bits each to the
stack, and takes 15 clock cycles to complete. The memory system may
require additional cycles for wait states. After completion of the
current instruction, the CPU performs a mode switch or pushes registers
on the stack (typically PC and flag registers). Modern CPUs such as ARM
generally perform a mode switch, which takes fewer CPU cycles than
saving registers. Pipeline fill: Most modern CPUs are pipelined.
Execution of an instruction happens in various stages of the pipeline.
An instruction is executed when it has reached its final stage of the
pipeline. Since the mode switch has flushed the pipeline, a few extra
cycles are required to refill the pipeline.

Q) Can we use any function inside ISR?
--------------------------------------

Yes, you can call a function within the ISR but it is not recommended
because it can increase the interrupt latency and decrease the
performance of the system. If you want to call a nested function within
the ISR, you need to read the datasheet of your microcontroller because
some vendors have a limit to how many calls can be nested.

One important point needs to remember that the function that is called
from the ISR should be re-entrant. If the called function is not
re-entrant, it could create the issues.

For example, If the function is not reentrant and supposes that it is
called by another part of the code beside the ISR. So the problem will
be invoked when if the ISR calls the same function which is already
invoked outside of the ISR?

Q) What is a nested interrupt?
------------------------------

In a nested interrupt system, an interrupt is allowed to any time and
anywhere even an ISR is being executed. But, only the highest priority
ISR will be executed immediately. The second highest priority ISR will
be executed after the highest one is completed.

The rules of a nested interrupt system are:

All interrupts must be prioritized. After initialization, any interrupts
are allowed to occur anytime and anywhere. If a low-priority ISR is
interrupted by a high-priority interrupt, the high-priority ISR is
executed. If a high-priority ISR is interrupted by a low-priority
interrupt, the high-priority ISR continues executing. The same priority
ISRs must be executed by time order

If you want to learn STM32 from scratch, you should follow this course
“Mastering Microcontroller with Embedded Driver Development“. The course
contains video lectures of 18.5-hours length covering all topics like,
Microcontroller & Peripheral Driver Development for STM32 GPIO, I2C,
SPI, USART using Embedded C.

Q) What is NVIC in ARM Cortex?
------------------------------

The Nested Vector Interrupt Controller (NVIC) in the Cortex-M processor
family is an example of an interrupt controller with extremely flexible
interrupt priority management. It enables programmable priority levels,
automatic nested interrupt support, along with support for multiple
interrupt masking, whilst still being very easy to use by the
programmer.

The Cortex-M3 and Cortex-M4 processors the NVIC supports up to 240
interrupt inputs, with 8 up to 256 programmable priority levels

Q) Can we change the interrupt priority level of Cortex-M processor family?
---------------------------------------------------------------------------

Yes, we can.

Q) Why “C” language mostly preferred than assembly language?
------------------------------------------------------------

C helps programmers focus on the structure of the code rather than the
low-level demands of the CPU. They can organize code into components,
such as functions and files and they have ways of managing the
complexity of a project; without thinking about the nitty-gritty of
issues such as how function calls work.

Since C is a portable language, code can be organized into
general-purpose libraries that can be used on any platform, often with
no modification. It is a great weapon against ‘reinventing the wheel.

Q) What is the start-up code?
-----------------------------

A start-up code is called prior to the main function, it creates a basic
platform for the application. It is a small block of code that is
written in assembly language.

There are the following parts of the start-up code.

Declaration of the Stack area. Declaration of the Heap area. Vector
table. Reset handler code. Other exception handler code.

Q) What are the start-up code steps?
------------------------------------

Start-up code for C programs usually consists of the following actions,
performed in the order described:

Disable all interrupts. Copy any initialized data from ROM to RAM
(.data). Zero the uninitialized data area (.bss). Allocate space for and
initialize the stack. Initialize the processor’s stack pointer. Create
and initialize the heap. Enable interrupts. Call main.

Q) Infinite loops often arise in embedded systems. How do you code an
---------------------------------------------------------------------

``` c
  infinite loop in C?
```

In embedded systems, infinite loops are generally used. If I talked
about a small program to control a led through the switch, in that
scenario an infinite loop will be required if we are not going through
the interrupt.

There are different ways to create an infinite loop, here I am
mentioning some methods.

Method 1:

``` c
  while(1) { // task }
```

Method 2:

``` c
  for(;;) { // task }
```

Method 3:

``` c
  Loop: goto Loop;
```

Q) How to access the fixed memory location in embedded C?
---------------------------------------------------------

Let us see an example code to understand this concept. This question is
one of the best questions of the embedded C interview question.

Suppose in an application, you need to access a fixed memory address. So
you need to follow the below steps, these are high-level steps.

``` c
#define RW_FLAG 0x1FFF7800		//Memory address, you want to access

volatile uint32_t *flagAddress = NULL; 	//Pointer to access the Memory address
uint32_t readData = 0; 			//variable to stored the read value

//Assign addres to the pointer
flagAddress = (volatile uint32_t*)RW_FLAG;
* flagAddress = 12; 			//Read value from memory
readData = * flagAddress;		//Write value to the memory
```

NOTE: This is how it is done in STM32 HAL

``` c
#define MY_PERIPHERAL_BASE (0xDEADBEEFUL)

typedef struct {
  const volatile uint32_t TYPE;
  volatile uint32_t CTRL;
} MyPeripheral_Type;

#define MyPeripheral ((MyPeripheral_Type *)MY_PERIPHERAL_BASE)

void My_Peripheral_write_ctrl() {
   MyPeripheral->CTRL = 0xABCD;
}
```

Q) Difference between RISC and CISC processor?
----------------------------------------------

The RISC (reduced instruction set computer) and CISC (Complex
instruction set computer) are the processors ISA (instruction set
architecture).

There are the following difference between both architecture:

Acronym It stands for ‘Reduced Instruction Set Computer’. It stands for
‘Complex Instruction Set Computer’. Definition The RISC processors have
a smaller set of instructions with few addressing nodes. The CISC
processors have a larger set of instructions with many addressing nodes.
Memory unit It has no memory unit and uses a separate hardware to
implement instructions. It has a memory unit to implement complex
instructions. Program It has a hard-wired unit of programming. It has a
micro-programming unit. Design It is a complex complier design. It is an
easy complier design. Calculations The calculations are faster and
precise. The calculations are slow and precise. Decoding Decoding of
instructions is simple. Decoding of instructions is complex. Time
Execution time is very less. Execution time is very high. External
memory It does not require external memory for calculations. It requires
external memory for calculations. Pipelining Pipelining does function
correctly. Pipelining does not function correctly. Stalling Stalling is
mostly reduced in processors. The processors often stall. Code expansion
Code expansion can be a problem. Code expansion is not a problem. Disc
space The space is saved. The space is wasted. Applications Used in
high-end applications such as video processing, telecommunications and
image processing. Used in low-end applications such as security systems,
home automations, etc. Images Courtesy: ics.uci.edu

Q) What is RISC-V? What are the claimed pros and cons?
------------------------------------------------------

Q) What is the stack overflow?
------------------------------

If your program tries to access beyond the limit of the available stack
memory then stack overflow occurs. In other words, you can say that a
stack overflow occurs if the call stack pointer exceeds the stack
boundary.

If stack overflow occurs, the program can crash or you can say that
segmentation fault that is the result of the stack overflow.

Q) What is the cause of the stack overflow?
-------------------------------------------

In the embedded application we have a little amount of stack memory as
compare to the desktop application. So we have to work on embedded
application very carefully either we can face the stack overflow issues
that can be a cause of the application crash.

Here, I have mentioned some causes of unwanted use of the stack.

      - Improper use of the recursive function.
      - Passing to many arguments in the function.
      - Passing a structure directly into a function.
      - Nested function calls.
      - Creating a huge size local array.

Q) What is the difference between the I2c and SPI communication protocols?
--------------------------------------------------------------------------

In the embedded system, I2C and SPI both play an important role. Both
communication protocols are the example of synchronous communication but
still, both have some important differences. Both target mainly
short-distance intraboard communication.

The important difference between the I2C and SPI communication protocol.

I2C supports half-duplex while SPI is full-duplex communication. I2C
requires only two-wire for communication while SPI requires three or
four-wire for communication (depends on requirement). I2C is slower as
compared to the SPI communication. I2C draws more power than SPI. I2C is
less susceptible to noise than SPI. I2C is cheaper to implement than the
SPI communication protocol. I2C work on wire and logic and it has a
pull-up resistor while there is no requirement of a pull-up resistor in
case of the SPI. In I2C communication we get the acknowledgment bit
after each byte, it is not supported by the SPI communication protocol.
I2C ensures that data sent is received by the slave device while SPI
does not verify that data is received correctly. I2C supports
multi-master communication while multi-master communication is not
supported by the SPI. One great difference between I2C and SPI is that
I2C supports multiple devices on the same bus without any additional
select lines (work on the basis of device address) while SPI requires
additional signal (slave select lines) lines to manage multiple devices
on the same bus. I2C supports arbitration while SPI does not support the
arbitration. I2C support the clock stretching while SPI does not support
the clock stretching. I2C can be locked up by one device that fails to
release the communication bus. I2C has some extra overhead due to start
and stop bits. I2C is better for long-distance while SPI is better for
the short distance. In the last I2C developed by NXP while SPI by
Motorola.

I2C - touch screen controller, RTC, GPIO expander

SPI - CAN controller, TPM

SPI max 10MHz, I2C origanally 100kHz

Lines:

-   serial clock line
-   data line MISO/MOSI and SDA
-   chip select

Q) What is the difference between Asynchronous and Synchronous communication?
-----------------------------------------------------------------------------

There are the following differences between asynchronous and synchronous
communication.

Asynchronous Communication Synchronous Communication There is no common
clock signal between the sender and receivers. Communication is done by
a shared clock. Sends 1 byte or character at a time. Sends data in the
form of blocks or frames. Slow as compare to synchronous communication.
Fast as compare to asynchronous communication. Overhead due to start and
stop bit. Less overhead. Ability to communicate long distance. Less as
compared to asynchronous communication. A start and stop bit used for
data synchronization. A shared clock is used for data synchronization.
Economical Costly RS232, RS485 I2C, SPI.

Q) What is the difference between RS232 and RS485?
--------------------------------------------------

The RS232 and RS485 is an old serial interface. Both serial interfaces
are the standard for data communication. This question is also very
important and generally ask by an interviewer.

Some important difference between the RS232 and RS485

Parameter RS232 RS485 Line configuration Single –ended differential
Numbers of devices 1 transmitter 1 receiver 32 transmitters 32 receivers
Mode of operation Simplex or full duplex Simplex or half duplex Maximum
cable length 50 feet 4000 feet Maximum data rate 20 Kbits/s 10 Mbits/s
signaling unbalanced balanced Typical logic levels +-5 \~ +-15V +-1.5 \~
+-6V Minimum receiver input impedance 3 \~ 7 K-ohm 12 K-ohm Receiver
sensitivity +-3V +-200mV

Q) What is the difference between Bit Rate and Baud Rate?
---------------------------------------------------------

Bit Rate \| Baud Rate \|

Bit rate is the number of bits per second \| Baud rate is the number of
signal units per second. \|

It determines the number of bits traveled per second. \| It determines
how many times the state of a signal is changing. \|

Cannot determine the bandwidth. \| It can determine how much bandwidth
is required to send the signal. \|

This term generally used to describe the processor efficiency. \| This
term generally used to describe the data transmission over the channel.

Bit rate = baud rate x the number of bits per signal unit \| Baud rate =
bit rate / the number of bits per signal unit \|

Q) What is segmentation fault in C?
-----------------------------------

A segmentation fault is a common problem that causes programs to crash.
A core file (core dumped file) also associated with a segmentation fault
that is used by the developer to finding the root cause of the crashing
(segmentation fault).

Generally, the segmentation fault occurs when a program tried to access
a memory location that is not allowed to access or tried to access a
memory location in a way that is not allowed (tried to access read-only
memory).

Q) What are the common causes of segmentation fault in C?
---------------------------------------------------------

There are many reasons for the segmentation fault, here I am listing
some common causes of the segmentation fault.

Dereferencing NULL pointers. Tried to write read-only memory (such as
code segment). Trying to access a nonexistent memory address (outside
process’s address space). Trying to access memory the program does not
have rights to (such as kernel structures in process context). Sometimes
dereferencing or assigning to an uninitialized pointer (because might
point an invalid memory) can be the cause of the segmentation fault.
Dereferencing the freed memory (after calling the free function) can
also be caused by the segmentation fault. A stack overflow is also
caused by the segmentation fault. A buffer overflow (try to access the
array beyond the boundary) is also a cause of the segmentation fault.

Q) What is the difference between Segmentation fault and Bus error?
-------------------------------------------------------------------

In the case of segmentation fault, SIGSEGV (11) signal is generated.
Generally, a segmentation fault occurs when the program tries to access
the memory to which it doesn’t have access to.

In below I have mentioned some scenarios where SIGSEGV signal is
generated.

When trying to de-referencing a NULL pointer. Trying to access memory
which is already de-allocated (trying to use dangling pointers). Using
uninitialized pointer(wild pointer). Trying to access memory that the
program doesn’t own (eg. trying to access an array element out of array
bounds).

In case of a BUS error, SIGBUS (10) signal is generated. The Bus error
issue occurs when a program tries to access an invalid memory or
unaligned memory. The bus error comes rarely as compared to the
segmentation fault.

In below I have mentioned some scenarios where SIGBUS signal is
generated.

Non-existent address. Unaligned access. Paging errors

Q) Size of the integer depends on what?
---------------------------------------

The C standard is explained that the minimum size of the integer should
be 16 bits. Some programing language is explained that the size of the
integer is implementation-dependent but portable programs shouldn’t
depend on it.

Primarily the size of integer depends on the type of the compiler which
has written by compiler writer for the underlying processor. You can see
compilers merrily changing the size of integer according to convenience
and underlying architectures. So it is my recommendation to use the C99
integer data types ( uin8\_t, uin16\_t, uin32\_t ..) in place of
standard int.

Q) Are integers signed or unsigned?
-----------------------------------

According to C standard, an integer data type is by default signed. So
if you create an integer variable, it can store both positive and
negative value.

For more details on signed and unsigned integer, check out: A closer
look at signed and unsigned integers in C

Q) How DMA works? What are some issues you need to worry when using DMA?
------------------------------------------------------------------------

Q) What is a difference between unsigned int and signed int in C?
-----------------------------------------------------------------

The signed and unsigned integer type has the same storage (according to
the standard at least 16 bits) and alignment but still, there is a lot
of difference them, in bellows lines, I am describing some difference
between the signed and unsigned integer.

A signed integer can store the positive and negative value both but
beside it unsigned integer can only store the positive value. The range
of nonnegative values of a signed integer type is a sub-range of the
corresponding unsigned integer type. For example, Assuming the size of
the integer is 2 bytes. signed int -32768 to +32767 unsigned int 0 to
65535 When computing the unsigned integer, it never gets overflow
because if the computation result is greater than the largest value of
the unsigned integer type, it is reduced modulo the number that is one
greater than the largest value that can be represented by the resulting
type. For example, Computational Result % (Largest value of the unsigned
integer+1) The overflow of the signed integer type is undefined. If Data
is signed type negative value, the right shifting operation of Data is
implementation-dependent but for the unsigned type, it would be Data/
2pos. If Data is signed type negative value, the left shifting operation
of Data shows the undefined behavior but for the unsigned type, it would
be Data x 2pos.

1.  What is the difference between a macro and a function?

macro VS function

1.  What is the difference between typedef & Macros?

Let’s see the short description of the typedef and macro to understand
the difference between them.

typedef:

The C language provides a very important keyword typedef for defining a
new name for existing types. The typedef is the compiler directive
mainly use with user-defined data types (structure, union or enum) to
reduce their complexity and increase code readability and portability.

Syntax,

typedef type NewTypeName;

Let’s take an example,

typedef unsigned int UnsignedInt; Now UnsignedInt is a new type and
using it, we can create a variable of unsigned int. So in the below
example, Mydata is unsigned int variable.

UnsignedInt Mydata; Note: A typedef creates synonyms or a new name for
existing types it does not create new types.

Macro:

A macro is a pre-processor directive and it replaces the value before
compiling the code. One of the major problems with the macro is that
there is no type checking. Generally, the macro is used to create the
alias, in C language. A macro is also used as a file guard in C and C++.

Syntax,

\#define MACRO\_NAME MACRO\_VALUE

Let’s take an example,

\#define VALUE 10 Now VALUE becomes 10 in your program. You can use the
VALUE in place of the 10.

For more details, you can see below-mentioned articles,

Macro in C. typedef vs \#define in C. typedef in C.

1.  What do you mean by enumeration in C?

An enum in C is a user-defined data type. It consists set of named
constant integers. Using the enum keyword, we can declare an enumeration
type by using the enumeration tag (optional) and a list of named
integer.

Basically, we used the enum to increase the code readability and with
enum easy to debug the code as compared to symbolic constant (macro).
The most important property of enum is that it follows the scope rule
and the compiler automatically assigns the value to its member constant.

Note: A variable of enumeration type stores one of the values of the
enumeration list defined by that type.

Syntax of enum,

enum Enumeration\_Tag { Enumeration\_List }; The Enumeration\_Tag
specifies the enumeration type name.

The Enumeration\_List is a comma-separated list of named constant.

Example,

enum FLASH\_ERROR { DEFRAGMENT\_ERROR, BUS\_ERROR};

For more details, you can see below-mentioned articles,

Macro in C. enum in C. typedef vs \#define in C.

1.  What is the difference between const and macro?

The const keyword is handled by the compiler, in another hand, a macro
is handled by the preprocessor directive. const is a qualifier that is
modified the behavior of the identifier but macro is preprocessor
directive. There is type checking is occurred with const keyword but
does not occur with \#define. const is scoped by C block, \#define
applies to a file. const can be passed as a parameter (as a pointer) to
the function. In the case of call by reference, it prevents to modify
the passed object value.

1.  How to set, clear, toggle and checking a single bit in C?

Note: Here I assume that bit of register starts with 0th position, it
means the 2nd position is actually 3rd bits.

D7 D6 D5 D4 D3 D2 D1 D0

Setting N-th Bit

Setting an N-th bit means that if the N-th bit is 0, then set it to 1
and if it is 1 then leave it unchanged. In C, bitwise OR operator (\|)
use to set a bit of integral data type. As we know that \| (Bitwise OR
operator) evaluates a new integral value in which each bit position is 1
only when operand’s (integer type) has a 1 in that position.

In simple words, you can say that “Bitwise OR” of two bits is always one
if any one of them is one.

That means, 0 \| 0 = 0 1 \| 0 = 1 0 \| 1 = 1 1 \| 1 = 1 Algorithm to set
the bits:

Number \| = (1UL \<\< nth Position);

Clearing a Bit

Clearing a bit means that if N-th bit is 1, then clear it to 0 and if it
is 0 then leave it unchanged. Bitwise AND operator (&) use to clear a
bit of integral data type. “AND” of two bits is always zero if any one
of them is zero.

That means, 0 & 0 = 0 1 & 0 = 0 0 & 1 = 0 1 & 1 = 1 Algorithm to clear
the bit:

To clear the nth bit, first, you need to invert the string of bits then
AND it with the number.

Number &= \~(1UL \<\< nth Position);

Checking a Bit

To check the nth bit, shift the ‘1’ nth position toward the left and
then “AND” it with the number.

An algorithm to check the bit

Bit = Number & (1UL \<\< nth);

Toggling a Bit

Toggling a bit means that if the N-th bit is 1, then change it to 0 and
if it is 0 then change it to 1. Bitwise XOR (^) operator use to toggle
the bit of an integral data type. To toggle the nth bit shift the ‘1’
nth position toward the left and “XOR” it.

That means, 0 ^ 0 = 0 1 ^ 0 = 1 0 ^ 1 = 1 1 ^ 1 = 0 An algorithm to
toggle the bits

Number ^= (1UL \<\< nth Position); You can see the below Articles,

C program to set, clear and toggle the bits of a register. Bitwise
interview Questions.

1.  What will be the output of the below C program?

\#include \<stdio.h\> int main() { char var = 10; void *ptr = &var;
printf(“%d %d”,*(char\*)ptr,++(\*(char\*)ptr)); return 0; } Output:
undefined

Explanation: Due to the sequence point the output vary on a different
platform.

1.  Write a program swap two numbers without using the third variable?

Let’s assume a, b two numbers, there are a lot of methods two swap two
numbers without using the third variable.

Method 1( (Using Arithmetic Operators):

\#include \<stdio.h\> int main() { int a = 10, b = 5; // algo to swap
‘a’ and ‘b’ a = a + b; // a becomes 15 b = a - b; // b becomes 10 a = a
- b; // fonally a becomes 5 printf(“After Swapping the value of: a = %d,
b = %d”, a, b); return 0; }

Method 2 (Using Bitwise XOR Operator):

\#include \<stdio.h\> int main() { int a = 10, b = 5; // algo to swap
‘a’ and ‘b’ a = a ^ b; // a becomes (a ^ b) b = a ^ b; // b = (a ^ b ^
b), b becomes a a = a ^ b; // a = (a ^ b ^ a), a becomes b printf(“After
Swapping the value of: a = %d, b = %d”, a, b); return 0; }

1.  What will be the output of the below C program?

\#include \<stdio.h\> \#define ATICLEWORLD 0x01 \#define AUTHOR 0x02 int
main() { unsigned char test = 0x00; test\|=ATICLEWORLD; test\|=AUTHOR;
if(test & ATICLEWORLD) { printf(“I am an Aticleworld”); } if( test &
AUTHOR) { printf(" Author"); } return 0; } Output: I am an Aticleworld
Author

Explanation:When we are OR-ing the test( unsigned char variable) with
0x01 and 0x02. The value of test will be 0x03 (because initially test
value is 0x00). When we perform the And-ing operatotion on test with
0x01 and 0x02 then expresstion will return non-zero value, for example
(0x00000011 & 0x00000001 =\> 0x00000010).

1.  What is meant by structure padding?

In the case of structure or union, the compiler inserts some extra bytes
between the members of structure or union for the alignment, these extra
unused bytes are called padding bytes and this technique is called
padding.

Padding has increased the performance of the processor at the penalty of
memory. In structure or union data members aligned as per the size of
the highest bytes member to prevent the penalty of performance.

Note: Alignment of data types mandated by the processor architecture,
not by language.

You can see the below Articles,

Brief Introduction of structure padding in C. Top 11 structure padding
interview questions in C.

1.  What is the endianness?

The endianness is the order of bytes to store data in memory and it also
describes the order of byte transmission over a digital link. In the
memory data store in which order depends on the endianness of the
system, if the system is big-endian then the MSB byte store first (means
at lower address) and if the system is little-endian then LSB byte store
first (means at lower address).

Some examples of the little-endian and big-endian system.

Embedded c interview questions

1.  What is big-endian and little-endian?

Suppose, 32 bits Data is 0x11223344.

little-endian

Big-endian

The most significant byte of data stored at the lowest memory address.

Embedded c interview questions

Little-endian

The least significant byte of data stored at the lowest memory address.

interview questions on embedded c

Note: Some processor has the ability to switch one endianness to other
endianness using the software means it can perform like both big-endian
or little-endian at a time. This processor is known as the Bi-endian,
here are some architecture (ARM version 3 and above, Alpha, SPARC) who
provide the switchable endianness feature.

1.  Write a C program to check the endianness of the system.

Method 1:

\#include \<stdio.h\> \#include \<stdlib.h\> \#include \<inttypes.h\>
int main(void) { uint32\_t u32RawData; uint8\_t \*pu8CheckData;
u32RawData = 0x11223344; //Assign data pu8CheckData = (uint8\_t
\*)&u32RawData; //Type cast if (\*pu8CheckData == 0x44) //check the
value of lower address { printf(“little-Endian”); } else if
(\*pu8CheckData == 0x11) //check the value of lower address {
printf(“big-Endian”); } return 0; }

Method 2:

\#include \<stdio.h\> \#include \<stdlib.h\> \#include \<inttypes.h\>
typedef union { uint32\_t u32RawData; // integer variable uint8\_t
au8DataBuff\[4\]; //array of character } RawData; int main(void) {
RawData uCheckEndianess; uCheckEndianess.u32RawData = 0x11223344;
//assign the value if (uCheckEndianess.au8DataBuff\[0\] == 0x44) //check
the array first index value { printf(“little-endian”); } else if
(uCheckEndianess.au8DataBuff\[0\] == 0x11) //check the array first index
value { printf(“big-endian”); } return 0; }

1.  How to Convert little-endian to big-endian vice versa in C?

We can convert little-endian to big-endian or vice versa using the C
programs. So let us see few ways to convert one endian to another.

\#include \<stdio.h\> \#include \<inttypes.h\> //Function to change one
endian to another uint32\_t ChangeEndianness(uint32\_t u32Value) {
uint32\_t u32Result = 0; u32Result \|= (u32Value & 0x000000FF) \<\< 24;
u32Result \|= (u32Value & 0x0000FF00) \<\< 8; u32Result \|= (u32Value &
0x00FF0000) \>\> 8; u32Result \|= (u32Value & 0xFF000000) \>\> 24;
return u32Result; } int main() { uint32\_t u32CheckData = 0x11223344;
uint32\_t u32ResultData =0; //swap the data u32ResultData =
ChangeEndianness(u32CheckData); //converted data
printf(“0x%x”,u32ResultData); return 0; } Output:

0x44332211

For more detail, you can see Article,

Little-endian vs Big-endian.

1.  What is static memory allocation and dynamic memory allocation?

According to C standard, there are four storage duration, static, thread
(C11), automatic, and allocated. The storage duration determines the
lifetime of the object.

The static memory allocation:

Static Allocation means, an object has an external or internal linkage
or declared with static storage-class. It’s initialized only once, prior
to program startup and its lifetime is throughout the execution of the
program. A global and static variable is an example of static memory
allocation.

The dynamic memory allocation:

In C language, there are a lot of library functions (malloc, calloc, or
realloc,..) which are used to allocate memory dynamically. One of the
problems with dynamically allocated memory is that it is not destroyed
by the compiler itself that means it is the responsibility of the user
to deallocate the allocated memory.

When we allocate the memory using the memory management function, they
return a pointer to the allocated memory block and the returned pointer
is pointing to the beginning address of the memory block. If there is no
space available, these functions return a null pointer.

1.  What is the memory leak in C?

A memory leak is a common and dangerous problem. It is a type of
resource leak. In C language, a memory leak occurs when you allocate a
block of memory using the memory management function and forget to
release it.

int main () { char \* pBuffer = malloc(sizeof(char) \* 20); /\* Do some
work \*/ return 0; /\*Not freeing the allocated memory\*/ }

Note: once you allocate a memory than allocated memory does not allocate
to another program or process until it gets free.

1.  What is the output of the below C code?

\#include \<stdio.h\> int main(void) { int var; for(var = -3 ; var
\<sizeof(int) ; var++) { printf(“Hello Aticleworld”); } return 0; }
Output:

Nothing will print.

Explanation: In the above C code, We are trying to compare a signed int
variable “var” with size\_t, which is defined as an unsigned long int
(sizeof operator return size\_t). Here integer promotion occurs and the
compiler will convert signed int -3 to unsigned long int and resultant
value would very large as compare to int size. So the for loop condition
will be false and there won’t be any iteration.

1.  What is the output of the below C code?

\#include \<stdio.h\> int main() { int pos = 14; float data = 15.2;
printf(“%\*f”,pos,data); return 0; } Output:

print 15.200000 with 6 spaces.

Explanation: The output will be \_\_\_\_\_\_15.20000, where \_ has been
used to represent space here. The program will print a floating-point
number with a width of at least 14 and since no precision has been
specified, it will take the default precision of 6 decimal point for
format specifier “f”.

The symbol \* can be used with a format specifier to replace the width
or precision. Here it has been used to replace the width. The general
format for %f can be seen as %(width). (precision)f. When \* is used to
specify width or precision. Let see a C code for the same.

\#include \<stdio.h\> int main() { int pos = 14; float data = 15.2;
printf(“%\*.\*f”,pos,2,data); return 0; } Output:

print 15.20 with spaces.

1.  What is the difference between malloc and calloc?

A malloc and calloc are memory management functions. They are used to
allocate memory dynamically. Basically, there is no actual difference
between calloc and malloc except that the memory that is allocated by
calloc is initialized with 0.

In C language,calloc function initialize the all allocated space bits
with zero but malloc does not initialize the allocated memory. These
both function also has a difference regarding their number of arguments,
malloc takes one argument but calloc takes two.

1.  What is the purpose of realloc( )?

The realloc function is used to resize the allocated block of memory. It
takes two arguments first one is a pointer to previously allocated
memory and the second one is the newly requested size.

The calloc function first deallocates the old object and allocates again
with the newly specified size. If the new size is lesser to the old
size, the contents of the newly allocated memory will be the same as
prior but if any bytes in the newly created object goes beyond the old
size, the values of the exceeded size will be indeterminate.

Syntax:

void \*realloc(void \*ptr, size\_t size);

Let’s see an example to understand the working of realloc in C language.

\#include \<stdio.h\> \#include \<stdlib.h\> \#include \<string.h\> int
main () { char *pcBuffer = NULL; /* Initial memory allocation */
pcBuffer = malloc(8); //make sure piBuffer is valid or not if (pcBuffer
== NULL) { // allocation failed, exit from the program fprintf(stderr,
“Out of memory!”); exit(1); } strcpy(pcBuffer, “aticle”);
printf(“pcBuffer = %s”, pcBuffer); /* Reallocating memory \*/ pcBuffer =
realloc(pcBuffer, 15); if (pcBuffer == NULL) { // allocation failed,
exit from the program fprintf(stderr, “Out of memory!”); exit(1); }
strcat(pcBuffer, “world”); printf(“pcBuffer = %s”, pcBuffer); //free the
allocated memory free(pcBuffer); return 0; } Output: pcBuffer = aticle
pcBuffer = aticleworld

Note: It should be used for dynamically allocated memory but if a
pointer is a null pointer, realloc behaves like the malloc function.

1.  What is the return value of malloc (0)?

If the size of the requested space is zero, the behavior will be
implementation-defined. The return value of the malloc could be a null
pointer or it shows the behavior of that size is some nonzero value. It
is suggested by the standard to not use the pointer to access an object
that is returned by the malloc while the size is zero.

1.  What is dynamic memory fragmentation?

The memory management function is guaranteed that if memory is
allocated, then it would be suitably aligned to any object which has the
fundamental alignment. The fundamental alignment is less than or equal
to the largest alignment that’s supported by the implementation without
an alignment specification.

One of the major problems with dynamic memory allocation is
fragmentation, basically, fragmentation occurred when the user does not
use the memory efficiently. There are two types of fragmentation,
external fragmentation, and internal fragmentation.

The external fragmentation is due to the small free blocks of memory
(small memory hole) that is available on the free list but the program
not able to use it. There are different types of free list allocation
algorithms that used the free memory block efficiently.

To understand the external fragmentation, consider a scenario where a
program has 3 contiguous blocks of memory and the user frees the middle
block of memory. In that scenario, you will not get a memory, if the
required block of memory is larger than a single block of memory (but
smaller or equal to the aggregate of the block of memory).

External Fragmentation

The internal fragmentation is wasted of memory that is allocated for
rounding up the allocated memory and in bookkeeping (infrastructure),
the bookkeeping is used to keep the information of the allocated memory.

Whenever we called the malloc function then it reserves some extra bytes
(depend on implementation and system) for bookkeeping. This extra byte
is reserved for each call of malloc and becomes a cause of the internal
fragmentation.

Internal fragmentation

For example, See the below code, the programmer may think that the
system will be allocated 8 *100 (800) bytes of memory but due to
bookkeeping (if 8 bytes) system will be allocated 8*100 extra bytes.
This is an internal fragmentation, where 50% of the heap waste.

char \*acBuffer\[100\]; int main() { int iLoop = 0; while(iLoop \< 100)
{ acBuffer\[iLoop \] = malloc(8); ++iLoop; } }

1.  How is the free work in C?

When we call the memory management functions (malloc, calloc or realloc)
then these functions keep extra bytes for bookkeeping. Whenever we call
the free function and pass the pointer that is pointing to allocated
memory, the free function gets the bookkeeping information and release
the allocated memory. Anyhow if you or your program change the value of
the pointer that is pointing to the allocated address, the calling of
the free function gives the undefined result.

\_\_\_\_ The allocated block \_\_\_\_ /  
+——–+——————–+ \| Header \| Your data area … \| +——–+——————–+ ^ \| +–
Returned Address

Let us see a program to understand the above concept. The behavior of
the below program is not defined.

\#include \<stdio.h\> \#include \<stdlib.h\> int main() { char
\*pcBuffer = NULL; //Allocate the memory pcBuffer = malloc(sizeof(char)
\* 16); //make sure piBuffer is valid or not if (pcBuffer == NULL) { //
allocation failed, exit from the program fprintf(stderr, “Out of
memory!”); exit(1); } //Increment the pointer pcBuffer++; //Call free
function to release the allocated memory free(pcBuffer); return 0; }
OutPut: Undefined Result

1.  What is a Function Pointer?

A function pointer is similar to the other pointers but the only
difference is that it points to a function instead of a variable. In
another word, we can say that a function pointer is a type of pointer
that store the address of a function and these pointed function can be
invoked by function pointer in a program whenever required.

1.  How to declare a pointer to a function in C?

The syntax for declaring function pointer is very straightforward. It
seems difficult in beginning but once you are familiar with function
pointer then it becomes easy.

The declaration of a pointer to a function is similar to the declaration
of a function. That means the function pointer also requires a return
type, declaration name, and argument list. One thing that you need to
remember here is, whenever you declare the function pointer in the
program then the declaration name is preceded by the \* (Asterisk)
symbol and enclosed in parenthesis.

For example,

void ( \*fpData )( int );

For a better understanding, let’s take an example to describe the
declaration of a function pointer in the C program. e.g,

void ( \*pfDisplayMessage) (const char \*); In the above expression,
pfDisplayMessage is a pointer to a function taking one argument, const
char \*, and returns void.

When we declare a pointer to function in c then there is a lot of
importance of the bracket. If in the above example, I remove the
bracket, then the meaning of the above expression will be change and it
becomes void \*pfDisplayMessage (const char \*). It is a declaration of
a function that takes the const character pointer as arguments and
returns a void pointer.

1.  Where can the function pointers be used?

There are a lot of places, where the function pointers can be used.
Generally, function pointers are used in the implementation of the
callback function, finite state machine and to provide the feature of
polymorphism in C language …etc.

1.  Write a program to check an integer is a power of 2?

Here, I am writing a small algorithm to check the power of 2. If a
number is a power of 2, function return 1.

int CheckPowerOftwo (unsigned int x) { return ((x != 0) && !(x & (x -
1))); }

1.  What is the output of the below code?

\#include \<stdio.h\> int main() { int x = -15; x = x \<\< 1;
printf(“%d”, x); } Output:

undefined behavior.

1.  What is the output of the below code?

\#include \<stdio.h\> int main() { int x = -30; x = x \>\> 1;
printf(“%d”, x); } Output:

implementation-defined.

1.  Write a program to count set bits in an integer?

unsigned int NumberSetBits(unsigned int n) { unsigned int CountSetBits=
0; while (n) { CountSetBits += n & 1; n \>\>= 1; } return CountSetBits;
}

1.  What is void or generic pointers in C?

A void pointer in c is called a generic pointer, it has no associated
data type. It can store the address of any type of object and it can be
type-casted to any type. According to C standard, the pointer to void
shall have the same representation and alignment requirements as a
pointer to a character type. A void pointer declaration is similar to
the normal pointer, but the difference is that instead of data types we
use the void keyword.

Syntax:

void \* Pointer\_Name; You can check these articles,

What is a void pointer? Dangling, Void, Null and Wild Pointer in C.
Generic LinkedList in C.

1.  What is the advantage of a void pointer in C?

There are following advantages of a void pointer in c.

Using the void pointer we can create a generic function that can take
arguments of any data type. The memcpy and memmove library function are
the best examples of the generic function, using these functions we can
copy the data from the source to destination. We know that void pointer
can be converted to another data type that is the reason malloc, calloc
or realloc library function return void \*. Due to the void \* these
functions are used to allocate memory to any data type. Using the void
\* we can create a generic linked list. For more information see this
link: How to create generic Link List.

1.  What are dangling pointers?

Generally, daggling pointers arise when the referencing object is
deleted or deallocated, without changing the value of the pointers. It
creates the problem because the pointer is still pointing the memory
that is not available. When the user tries to dereference the daggling
pointers than it shows the undefined behavior and can be the cause of
the segmentation fault.

For example,

\#include\<stdio.h\> \#include\<stdlib.h\> int main() { int *piData =
NULL; //creating integer of size 10. piData = malloc(sizeof(int)* 10);
//make sure piBuffer is valid or not if (piData == NULL) { // allocation
failed, exit from the program fprintf(stderr, “Out of memory!”);
exit(1); } //free the allocated memory free(piData); //piData is
dangling pointer \*piData = 10; printf(“%d”,\*piData); return 0; }
OutPut: Undefined Result

In simple words, we can say that a dangling pointer is a pointer that is
not pointing to valid memory. So if we access these pointers then the
behaviour of the program will undefine.

1.  What is the wild pointer?

A pointer that is not initialized properly prior to its first use is
known as the wild pointer. Uninitialized pointer’s behavior is totally
undefined because it may point some arbitrary location that can be the
cause of the program crash, that’s is the reason it is called a wild
pointer.

In other words, we can say every pointer in programming languages that
are not initialized either by the compiler or programmer begins as a
wild pointer.

Note: Generally, compilers warn about the wild pointer.

Syntax,

int \*piData; //piData is wild pointer.

1.  What is a NULL pointer?

According to C standard, an integer constant expression with the value
0, or such an expression cast to type void \*, is called a null pointer
constant. If a null pointer constant is converted to a pointer type, the
resulting pointer, called a null pointer.

wild pointer

Syntax,

int \*piData = NULL; // piData is a null pointer

1.  What are the post-increment and decrement operators?

When we use a post-increment (++) operator on an operand then the result
is the value of the operand and after getting the result, the value of
the operand is incremented by 1. The working of the post-decrement (–)
operator is similar to the post-increment operator but the difference is
that the value of the operand is decremented by 1.

Note: incrementation and decrementation by 1 are the types specified.

1.  Which one is better: Pre-increment or Post increment?

Nowadays compiler is enough smart, they optimize the code as per the
requirements. The post and pre-increment both have their own importance
we need to use them as per the requirements.

If you are reading a flash memory byte by bytes through the character
pointer then here you have to use the post-increment, either you will
skip the first byte of the data. Because we already know that in the
case of pre-increment pointing address will be increment first and after
that, you will read the value.

Let’s take an example of the better understanding, In the below example
code, I am creating a character array and using the character pointer I
want to read the value of the array. But what will happen if I used a
pre-increment operator? The answer to this question is that ‘A’ will be
skipped and B will be printed.

\#include \<stdio.h\> int main(void) { char acData\[5\] =
{‘A’,‘B’,‘C’,‘D’,‘E’}; char *pcData = NULL; pcData = acData;
printf(“%c”,*++pcData); return 0; }

But in place of pre-increment if we use post-increment then the problem
is getting solved and you will get A as the output.

\#include \<stdio.h\> int main(void) { char acData\[5\] =
{‘A’,‘B’,‘C’,‘D’,‘E’}; char \*pcData = NULL; pcData = acData;
printf(“%c”,\*pcData++); return 0; }

Besides that, when we need a loop or just only need to increment the
operand then pre-increment is far better than post-increment because in
case of post increment compiler may have created a copy of old data
which takes extra time. This is not 100% true because nowadays the
compiler is so smart and they are optimizing the code in a way that
makes no difference between pre and post-increment. So it is my advice,
if post-increment is not necessary then you have to use the
pre-increment.

Note: Generally post-increment is used with array subscript and pointers
to read the data, otherwise if not necessary then use pre in place of
post-increment. Some compiler also mentioned that to avoid to use
post-increment in looping condition. iLoop = 0.

while (a\[iLoop ++\] != 0) { // Body statements }

1.  Are the expressions \*ptr ++ and ++\*ptr same ?

Both expressions are different. Let’s see a sample code to understand
the difference between both expressions.

\#include \<stdio.h\> int main(void) { int aiData\[5\] =
{100,200,300,400,500}; int \*piData = aiData; ++\*piData;
printf("aiData\[0\] = %d, aiData\[1\] = %d, \*piData = %d", aiData\[0\],
aiData\[1\], \*piData); return 0; } Output: 101 , 200 , 101

Explanation: In the above example, two operators are involved and both
have the same precedence with a right to left associativity. So the
above expression ++\*p is equivalent to ++ (\*p). In another word, we
can say it is pre-increment of value and output is 101, 200, 101.

\#include \<stdio.h\> int main(void) { int aiData\[5\] =
{100,200,30,40,50}; int \*piData = aiData; \*++piData;
printf("aiData\[0\] = %d, aiData\[1\] = %d, \*piData = %d", aiData\[0\],
aiData\[1\], \*piData); return 0; } Output: 100, 200, 200

Explanation: In the above example, two operators are involved and both
have the same precedence with the right to left associativity. So the
above expression \*++p is equivalent to \*(++p). In another word you can
say it is pre-increment of address and output is 100, 200,200.

1.  What does the keyword const mean?

A const is only a qualifier, it changes the behavior of a variable and
makes it read-only type. When we want to make an object read-only type,
then we have to declare it as const.

Syntax,

const DataType Identifier = Value; e.g.

const int iData = 0

const

At the time of declaration, const qualifier only gives the direction to
the compiler that the value of declaring objects could not be changed.
In simple words, const means not modifiable (cannot assign any value to
the object at the runtime).

1.  When should we use const in a C program?

There are the following places where we need to use the const keyword in
the programs.

In case of call by reference, if you don’t want to change the value of
the passed variable. For e.g., int PrintData ( const char \*pcMessage);
In some places, const is better than macro because const handled by the
compiler and have a type checking. In the case of the I/O and
memory-mapped register, const is used with the volatile qualifier for
efficient access. for eg, const volatile uint32\_t \*DEVICE\_STATUS =
(uint32\_t \*) 0x80102040; When you don’t want to change the value of an
initialized variable.

1.  What is the meaning of the below declarations?

const int a; int const a; const int \*a; int \* const a; int const \* a
const; The “a” is a constant integer. Similar to first, “a” is a
constant integer. Here “a” is a pointer to a const integer, the value of
the integer is not modifiable, but the pointer is not modifiable. Here
“a” is a const pointer to an integer, the value of the pointed integer
is modifiable, but the pointer is not modifiable. Here “a” is a const
pointer to a const integer that means the value of pointed integer and
pointer both are not modifiable.

1.  Differentiate between a constant pointer and pointer to a constant?

Constant pointer:

A constant pointer is a pointer whose value (pointed address) is not
modifiable. If you will try to modify the pointer value, you will get
the compiler error.

A constant pointer is declared as follows :

Data\_Type \* const Pointer\_Name;

Let’s see the below example code when you will compile the below code to
get the compiler error.

\#include\<stdio.h\> int main(void) { int var1 = 10, var2 = 20;
//Initialize the pointer int \*const ptr = &var1; //Try to modify the
pointer value ptr = &var2; printf(“%d”, \*ptr); return 0; } Output:
compiler error.

Pointer to a constant:

In this scenario the value of the pointed address is constant that means
we can not change the value of the address that is pointed by the
pointer.

A constant pointer is declared as follows :

Data\_Type const\* Pointer\_Name;

Let’s take a small code to illustrate a pointer to a constant:

\#include\<stdio.h\> int main(void) { int var1 = 100; // pointer to
constant integer const int\* ptr = &var1;

      //try to modify the value of pointed address
      *ptr = 10;
      
      printf("%d\n", *ptr);
      return 0;

}

Output: compiler error.

1.  What are the uses of the keyword static?

In C language, the static keyword has a lot of importance. If we have
used the static keyword with a variable or function, then only internal
or none linkage is worked. I have described some simple use of a static
keyword.

A static variable only initializes once, so a variable declared static
within the body of a function maintains its prior value between function
invocations. A global variable with a static keyword has internal
linkage, so it only accesses within the translation unit (.c). It is not
accessible by another translation unit. The static keyword protects your
variable to access from another translation unit. By default in C
language, the linkage of the function is external that it means it is
accessible by the same or another translation unit. With the help of the
static keyword, we can make the scope of the function local, it only
accesses by the translation unit within it is declared.

1.  What is the difference between global and static global variables?

Global and static global variables have different linkages. It is the
reason global variables can be accessed outside of the file but the
static global variable only accesses within the file in which it is
declared.

A static global variable ===\>\>\> internal linkage. A non-static global
variable ===\>\>\> external linkage.

For more details, you can see below-mentioned articles,

Internal, External and None linkage in c. Local, Static and Global
variables in C.

1.  Differentiate between an internal static and external static
    variable?

In C language, the external static variable has the internal linkage and
the internal static variable has no linkage. It is the reason they have
a different scope but both will alive throughout the program.

A external static variable ===\>\>\> internal linkage. A internal static
variable ===\>\>\> none .

1.  Can static variables be declared in a header file?

Yes, we can declare the static variables in a header file.

1.  What is the difference between declaration and definition of a
    variable?

Declaration of a variable in C

A variable declaration only provides sureness to the compiler at the
compile time that variable exists with the given type and name, so that
compiler proceeds for further compilation without needing all detail of
this variable. In C language, when we declare a variable, then we only
give the information to the compiler, but there is no memory reserve for
it. It is only a reference, through which we only assure the compiler
that this variable may be defined within the function or outside of the
function.

Note: We can declare a variable multiple times but defined only once.
eg,

extern int data; extern int foo(int, int); int fun(int, char); // extern
can be omitted for function declarations

Definition of variable in C

The definition is action to allocate storage to the variable. In another
word, we can say that variable definition is the way to say the compiler
where and how much to create the storage for the variable generally
definition and declaration occur at the same time but not almost.

eg,

int data; int foo(int, int) { } Note: When you define a variable then
there is no need to declare it but vice versa is not applicable.

1.  What is the difference between pass by value by reference in c and
    pass by reference in c?

Pass By Value:

In this method, the value of the variable is passed. Changes made to
formal will not affect the actual parameters. Different memory locations
will be created for both variables. Here there will be a temporary
variable created in the function stack which does not affect the
original variable. Pass By Reference :

In Pass by reference, an address of the variable is passed to a
function. Whatever changes made to the formal parameter will affect the
value of actual parameters(a variable whose address is passed). Both
formal and actual parameters shared the same memory location. it is
useful when you required to returns more than 1 value. Q) What is a
reentrant function?

In computing, a computer program or subroutine is called reentrant if it
can be interrupted in the middle of its execution and then safely be
called again (“re-entered”) before its previous invocations complete
execution. The interruption could be caused by an internal action such
as a jump or call, or by an external action such as an interrupt or
signal. Once the reentered invocation completes, the previous
invocations will resume correct execution.

1.  What is the inline function?

An inline keyword is a compiler directive that only suggests the
compiler to substitute the body of the function at the calling the
place. It is an optimization technique used by the compilers to reduce
the overhead of function calls.

for example,

static inline void Swap(int \*a, int \*b) { int tmp= \*a; \*a= \*b; \*b
= tmp; }

1.  What is the advantage and disadvantage of the inline function?

There are a few important advantage and disadvantage of the inline
function.

Advantages:- 1) It saves the function calling overhead. 2) It also saves
the overhead of variables push/pop on the stack, while function calling.
3) It also saves the overhead of return call from a function. 4) It
increases the locality of reference by utilizing the instruction cache.
5) After inlining compiler can also apply intraprocedural optimization
if specified. This is the most important one, in this way compiler can
now focus on dead code elimination, can give more stress on branch
prediction, induction variable elimination, etc..

Disadvantages:- 1) May increase function size so that it may not fit in
the cache, causing lots of cache miss. 2) After inlining function, if
variables numbers which are going to use register increases than they
may create overhead on register variable resource utilization. 3) It may
cause compilation overhead as if somebody changes code inside an inline
function then all calling locations will also be compiled. 4) If used in
the header file, it will make your header file size large and may also
make it unreadable. 5) If somebody used too many inline functions
resultant in a larger code size than it may cause thrashing in memory.
More and number of page faults bringing down your program performance.
6) It’s not useful for an embedded system where large binary size is not
preferred at all due to memory size constraints.

1.  What is virtual memory?

The virtual memory is the part of memory management techniques and it
creates an illusion that the system has a sufficient amount of memory.
In other words, you can say that virtual memory is a layer of
indirection.

1.  Consider the two statements and find the difference between them?

struct sStudentInfo { char Name\[12\]; int Age; float Weight; int
RollNumber; }; \#define STUDENT\_INFO struct sStudentInfo\* typedef
struct sStudentInfo\* studentInfo; statement 1 STUDENT\_INFO p1, p2;
statement 2 studentInfo q1, q2;

Both statements looking the same but actually, both are different from
each other.

Statement 1 will be expanded to struct sStudentInfo \* p1, p2. It means
that p1 is a pointer to struct sStudentInfo but p2 is a variable of
struct sStudentInfo.

In statement 2, both q1 and q2 will be a pointer to struct sStudentInfo.

1.  What are the limitations of I2C interface?

Half-duplex communication, so data is transmitted only in one direction
(because of the single data bus) at a time. Since the bus is shared by
many devices, debugging an I2C bus (detecting which device is
misbehaving) for issues is pretty difficult. The I2C bus is shared by
multiple slave devices if anyone of these slaves misbehaves (pull either
SCL or SDA low for an indefinite time) the bus will be stalled. No
further communication will take place. I2C uses resistive pull-up for
its bus. Limiting the bus speed. Bus speed is directly dependent on the
bus capacitance, meaning longer I2C bus traces will limit the bus speed.

1.  What is Featured of CAN Protocol?

There are few features of can protocol.

Simple and flexible in Configuration. CAN is a Message-Based Protocol.
Message prioritization feature through identifier selection. CAN offer
Multi-master Communication. Error Detection and Fault Confinement
feature. Retransmission of the corrupted message automatically when the
bus is idle. I believe that the above mentioned embedded C interview
questions are helpful. Here, I have mentioned some unsolved embedded c
interview questions for you. If you know the answer to the mentioned
embedded c interview questions, please write in the comment box. Might
be your comment helpful for others.

What is the difference between C and embedded C? What is the difference
between flash memory, EPROM, and EEPROM? What is the difference between
Volatile & Non Volatile Memory? What are the differences between a union
and a structure in C? What is the difference between RS232 and UART? Is
it possible to declare struct and union one inside other? Explain with
example. How to find the bug in code using the debugger if the pointer
is pointing to an illegal value. What is a watchdog timer? What is DMA?
What is RTOS? What are CAN and its uses? Why is CAN having 120 ohms at
each end? Why is CAN message-oriented protocol? What is the Arbitration
in the CAN? Standard CAN and Extended CAN difference? What is the use of
bit stuffing? How many types of IPC mechanisms do you know? What is
semaphore? What is the spinlock? What is the difference between c and
embedded C? Convert a given decimal number to hex. What is the
difference between heap and stack memory? What is socket programming?
How can a double-pointer be useful? What is the difference between
binary semaphore and mutex? CAN frame-works? How CAN will follow the
Arbitration? Explain CAN architecture with respect to OSI Layer? What
are the functions of CAN transceiver? Why CAN Bus Topology uses
terminator register at the end? Explain High-Speed CAN and Low-Speed
CAN? Explain the types of CAN error? Which concept is used behind bit
error detection? What are an active error, passive error, and Bus-off
state? What is bit time? Calculate no. of time quanta required to
achieve 500kbps bit rate if system frequency is 40mhz and clock divider
is 4? How many Types of CAN frame exist? explain the functionality of
each frame? What is CSMA/CA and CSMA/CD in CAN Communication? Can
Standard CAN and extended CAN coexist in the same network? who will win
arbitration if first arbitration field is the same? What is the
difference between the C and embedded C? What is the sequential point in
C? Recommended Post

Can protocol interview Questions. HDLC Protocol introduction. 100 C
interview Questions. Embedded system interview Questions with Answers
I2C interview Questions Interview questions on bitwise operators in C
C++ Interview Questions. 10 questions about dynamic memory allocation.
File handling in C. Pointer in C. C format specifiers. You can see this
link for more detail about ISR.

THIS ENTRY WAS POSTED IN 8051 MICRO-CONTROLLER, C LANGUAGE,
COMMUNICATION PROTOCOL, PIC MICROCONTROLLER AND TAGGED FEATURED.
BOOKMARK THE PERMALINK. About Amlendra I am an embedded c software
engineer and a corporate trainer, currently, I am working as senior
software engineer in a largest Software consulting company . I have
working experience of different microcontrollers (stm32, LPC, PIC AVR
and 8051), drivers (USB and virtual com-port), POS device (VeriFone) and
payment gateway (global and first data). WEBSITE Post navigation NEXT
ARTICLE

steps to learn c language 12 Steps in Mastering C Language (Infographic)

AMLENDRA/ PREVIOUS ARTICLE

bit field in c Bit field in c, you should know

AMLENDRA/ 89 comments Niraj APRIL 6, 2018 AT 3:32 PM Const does not mean
that value of variable can not modified, it only mean the variable can
not occur at left side of a assignment operator. I can modify the value
of const variable by first initialising its address into a pointer and
then using pointer its value can be changed. REPLY Amlendra APRIL 7,
2018 AT 10:18 AM const is just an qualifier. If you will try to change
the value of const through the pointer, then behavior is undefined.
According to C standard “If an attempt is made to modify an object
defined with a const-qualified type through use of an lvalue with
non-const-qualified type, the behavior is undefined.”. So it is not
recommended to change the value of constant variable.. REPLY alok APRIL
7, 2018 AT 10:25 AM Can you tell me what is difference between structure
and union in c? REPLY Amlendra APRIL 7, 2018 AT 10:28 AM See this
article: [https://aticleworld.com/union-in-c/] REPLY Pooja APRIL 7, 2018
AT 10:43 AM Somebody asked me a question to multiply a integer number
with 3.5 using bitwise operation. Can you give me answer of this
question. REPLY Amlendra APRIL 7, 2018 AT 10:47 AM You can simply
multiply an integer number with 3.5 using the shifting operators.

See this article that will be helpful for you,
[https://aticleworld.com/interview-questions-on-bitwise-operators-in-c/]
REPLY Dhiraj Jadhav JUNE 6, 2018 AT 4:02 PM Volatile Memory is a type of
memory in which data contained in the memory is lost whenever the power
is turned off. RAM or Random Access Memory is an example of a volatile
memory. … ROM is an example of the Non-volatile memory as once the user
turns off your computer then content remains intact and will not get
lost. REPLY Amlendra JUNE 7, 2018 AT 2:20 PM Thanks for the reply. REPLY
Naman JUNE 8, 2018 AT 12:24 AM Watchdog timer is a special type of timer
used to monitor any sofware failure in microcontroller. Software failure
i.e if system hangs due to some problem and does not able to execute the
code than watchdog timer has the capability to generate a power reset so
that microcontroller starts running again . It is different from normal
timer because normal timer can only generate interrupt or any signal but
not power reset. It is important in microcontroller applications because
in most of the applications user does not have any access on controller
so if some problem occurs ,only watchdog timer can save it from system
failure. REPLY Amlendra JUNE 10, 2018 AT 7:43 PM Thanks for your
valuable answer. REPLY suresh.pv JULY 4, 2018 AT 1:01 PM very very very
good and usefull information for embedded students and employes. REPLY
Amlendra JULY 4, 2018 AT 2:31 PM Thank you so much. REPLY Anushree
AUGUST 3, 2018 AT 11:59 AM I just completed reading 100 Embedded C
interview questions. I am able to brush up many things. Really really
good source of questions and answers. Thanks a lot REPLY Amlendra AUGUST
3, 2018 AT 11:05 PM Thank you so much. REPLY ANJU SEPTEMBER 4, 2018 AT
9:30 AM A nice quick read for preparation of interview.Liked it. REPLY
Amlendra SEPTEMBER 4, 2018 AT 10:18 AM thank you. REPLY alasklany
SEPTEMBER 18, 2018 AT 7:05 PM Very good info REPLY Amlendra SEPTEMBER
19, 2018 AT 2:28 PM Thanks. REPLY surya OCTOBER 12, 2018 AT 8:47 PM can
you same that how to write a c program to know the processor(not
compiler ) is 32 bit or 64 bit REPLY surya OCTOBER 12, 2018 AT 8:56 PM
required device driver specific interview question and c ++ also REPLY
Kalai NOVEMBER 7, 2018 AT 10:57 PM We can not reduce the interrupt
latency by making the ISR shorter and avoid to calling a function within
the ISR.

Basically Interrupt latency is time taken for switching from interrupted
task to executing first instruction of ISR. So even though you have
shorter ISR, Interrupt latency can not be reduced.

Instead Interrupt Dispatch latency can be minimised. Dispatch latency is
time taken between executing last instruction of ISR to resuming the
interrupted task. REPLY Nalini NOVEMBER 13, 2018 AT 8:40 AM please
provide device driver and rtos interview questions REPLY Dj1 NOVEMBER
14, 2018 AT 10:53 AM Q.What is minimum voltage measurement of the 8 bit
adc? A. Vref/2^8 (Vref/256) REPLY arunprasad NOVEMBER 27, 2018 AT 2:30
PM hai sir ,i need a favor,can you please upload a tutorial for
interrupt for embedded micro-controllers. REPLY Amlendra NOVEMBER 28,
2018 AT 11:54 AM Thanks, I will do. REPLY Thejas patil DECEMBER 18, 2018
AT 5:12 PM Thank you so much Amlendra and I appreciate your effort.

Could you give me the sample code of CAN to work on LPC1768!! REPLY
Himabindu FEBRUARY 28, 2019 AT 11:27 AM Just wow, amazing article. I
could able to brush up all basics in embedded C by reading this article.
Thanks a lot Amlendra for your effort. REPLY Amlendra MARCH 2, 2019 AT
11:44 AM Thank you so much. REPLY Saju MARCH 28, 2019 AT 10:43 PM Great
article for Embedded employees, thanks a lot REPLY JAIKRISHNA MAY 20,
2019 AT 7:50 PM Informative questions to attend job interview REPLY
karthik Karthik MAY 21, 2019 AT 2:52 PM THANK YOU……… REPLY Gaurav Ate
AUGUST 31, 2019 AT 1:47 PM Tell me when computer processor is 64 bit and
compiler is 32 bit then 1cycle how many bytes processor read from
memory. REPLY Monzurul Islam SEPTEMBER 10, 2019 AT 12:04 AM Resourcefull
post, i learned and brushed up my learning to a great extent. I believe
one correction is needed regarding checking bit position of a number…
checking Nth bit position of a number NUM will be : (NUM\>\>(N-1)) & 1 ,
REPLY Amlendra SEPTEMBER 10, 2019 AT 1:40 PM Thank you so much, In my
case n start from 0. I will mention in article. REPLY Pingback: 8051
Microcontroller Pin Diagram and Pin Description - AticleWorld Pingback:
Can protocol interview questions and answers in detail - AticleWorld
Pingback: Interfacing of switch and led using the 8051 - AticleWorld
Pingback: Pointers in c language: A brief description - AticleWorld
Pingback: Interfacing of keypad with 8051 microcontroller. - AticleWorld
Pingback: moving message display on LCD using 8051 microcontroller. -
AticleWorld Pingback: Create LCD custom characters for 16x2 alphanumeric
LCD - AticleWorld Pingback: Interfacing of Relay with microcontroller -
AticleWorld Pingback: interfacing of EEPROM with 8051 microcontroller
using I2C - AticleWorld Pingback: Application of volatile and const
keywords in C - AticleWorld Pingback: Little endian to Big endian
conversion and its Importance - Aticleworld Pingback: C program to
create calculator using switch case - AticleWorld Pingback: Top 15
string Interview Questions in C, might ask by the interviewer. -
AticleWorld Pingback: typedef vs \#define in c, you should know -
AticleWorld Pingback: How to set, clear or toggle a single bit in C/C++?

-   AticleWorld Pingback: Python Interview Questions and Answers -
    AticleWorld Pingback: 10 questions about dynamic memory allocation,
    your interviewer might ask. - AticleWorld Pingback: A brief
    description of increment and decrement operators in c. - AticleWorld
    Pingback: Display Custom Characters on LCD using PIC
    Microcontroller - AticleWorld Pingback: Interfacing RTC DS1307 with
    PIC Microcontroller - AticleWorld Pingback: I2C Interview Questions,
    You should know - AticleWorld Pingback: Led Interfacing with PIC
    Microcontroller - AticleWorld Pingback: Access GPIO and Register
    using the Bit field - AticleWorld Pingback: Find the smallest and
    second smallest element in an array - AticleWorld Pingback:
    Difference between pointer to an array and array of pointers -
    AticleWorld Pingback: SPI Interview Questions,You should know -
    AticleWorld Pingback: C interview questions, your interviewer might
    ask - AticleWorld Pingback: C Interview Questions for Experienced
    with Answer - AticleWorld Pingback: C\# Interview Questions and
    Answers,You Need To Know - AticleWorld Pingback: How to make(build)
    a calculator using Pic microcontroller - AticleWorld Pingback: C++
    Interview Questions,Your interviewer might ask - AticleWorld
    Pingback: Embedded System Interview Questions with Answers -
    AticleWorld Pingback: linux commands you should know - AticleWorld
    Pingback: What is Memory Leak in C/C++? How can we avoid? -
    AticleWorld Pingback: Difference Between High-level Data Link
    Control (HDLC) and Point-to-Point Protocol (PPP) - AticleWorld
    Pingback: HDLC Protocol (High-level Data Link Control Protocol) -
    AticleWorld Pingback: Understanding Linear Regression - AticleWorld
    Pingback: Difference between Active and Reactive Power (Active vs
    Reactive) - AticleWorld Pingback: 15 Common mistakes with memory
    allocation, you should avoid - AticleWorld Pingback: Difference
    between I2C and SPI ( I2C vs SPI ), you should know. - AticleWorld
    Pingback: Advantage of virtual memory in operating system -
    AticleWorld Pingback: Interview questions on virtual keyword in
    C++ - AticleWorld Pingback: Interview Questions on Inheritance in
    C++ - AticleWorld Pingback: Format specifiers in C Programming
    language - AticleWorld Pingback: Dynamic memory allocation in C, a
    brief introduction - AticleWorld Pingback: Active, Reactive and
    Apparent Power
-   AticleWorld Pingback: Difference between SSL and TLS (SSL vs TLS) -
    AticleWorld Mahesh k AUGUST 4, 2020 AT 6:05 PM Thanks for your
    valuable articles and your contribution make best community.. REPLY
    Amlendra AUGUST 5, 2020 AT 8:44 AM Thanks, Mahesh, also please share
    this article if possible for you. REPLY aalokshah2016 AUGUST 9, 2020
    AT 7:24 PM Good Composition, Thanks! REPLY Amlendra AUGUST 13, 2020
    AT 5:22 PM Thanks, please let me know if you have any suggestion.
    REPLY

  [/r/embedded]: https://old.reddit.com/r/embedded/comments/bqoqpr/what_are_some_more_obscure_interview_questions/
  [https://aticleworld.com/union-in-c/]: https://aticleworld.com/union-in-c/
  [https://aticleworld.com/interview-questions-on-bitwise-operators-in-c/]:
    https://aticleworld.com/interview-questions-on-bitwise-operators-in-c/
