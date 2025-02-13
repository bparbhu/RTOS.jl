# RTOS.jl - Real-Time Operating System for Julia

## 🚀 Overview
**RTOS.jl** is a high-performance **real-time operating system (RTOS)** built entirely in Julia. It is designed for **embedded systems, real-time applications, and mission-critical computing**, offering a feature set competitive with **FreeRTOS and PyRTOS**, but leveraging Julia's powerful numerical and parallel computing capabilities.

## 🌟 Features
- **Preemptive & Priority Scheduling**
- **Inter-Process Communication (IPC)**
- **Task Lifecycle Management (Create, Suspend, Resume, Stop)**
- **High-Precision Timers**
- **Interrupt Handling**
- **Memory Management & Dynamic Allocation**
- **Synchronization Primitives:**
  - Mutex with Priority Inheritance
  - Binary & Counting Semaphores
  - Task Notifications
- **Safety Mechanisms:**
  - Deadlock Prevention
  - Watchdog Timers
- **Real-Time Debugging & Logging**
- **Static Compilation for Embedded Systems** (via `StaticCompiler.jl`)

## 📂 Project Structure
```
RTOS.jl/
│── src/
│   │── RTOS.jl           # Main entry point
│   │── Scheduler.jl      # Task scheduling
│   │── Task.jl           # Task management
│   │── IPC.jl            # Message queues & communication
│   │── Memory.jl         # Memory management
│   │── Timers.jl         # Real-time timers
│   │── RTOSCompiler.jl   # Static compilation support
│   │── Interrupts.jl     # Interrupt handling
│   │── Drivers.jl        # Device drivers
│   │── Debug.jl          # Logging & debugging
│   │── Utils.jl          # Utility functions
│   │── Safety.jl         # Deadlock prevention & watchdogs
│   │── Sync.jl           # Mutexes, Semaphores, Notifications
│── test/
│   │── runtests.jl       # Test runner
│   │── test_scheduler.jl # Scheduler tests
│   │── test_task.jl      # Task management tests
│   │── test_ipc.jl       # IPC tests
│   │── test_memory.jl    # Memory management tests
│   │── test_timers.jl    # Timer tests
│   │── test_safety.jl    # Safety tests
│   │── test_sync.jl      # Synchronization tests
```

## 🛠 Installation
RTOS.jl is currently in development. To install it from source:
```julia
using Pkg
Pkg.clone("https://github.com/bparbhu/RTOS.jl")
```

## 🚦 Quick Start
```julia
using RTOS

# Create and start a task
function example_task()
    println("Running real-time task")
end

create_task("my_task", example_task, 5)
start_scheduler()
```

## ⚡ Synchronization Example
```julia
using Sync

create_mutex("resource_mutex")
lock_mutex("resource_mutex", "task_1")
unlock_mutex("resource_mutex")
```

## 🔬 Testing
Run all tests:
```sh
julia --project=test test/runtests.jl
```
Or inside the Julia REPL:
```julia
using Pkg
Pkg.test()
```

## 🔧 Roadmap
- ✅ Full preemptive scheduling
- ✅ Synchronization primitives (mutex, semaphores, notifications)
- ⏳ Advanced profiling & performance benchmarking
- ⏳ Extended driver support
- ⏳ Integration with Julia embedded tooling

## 🤝 Contributing
We welcome contributions! Feel free to open issues and pull requests.

## 📜 License
RTOS.jl is licensed under the **MIT License**.
