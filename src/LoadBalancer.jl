module LoadBalancer
using ThreadsX
export balance_load

balance_load(tasks) = ThreadsX.map(task -> task(), tasks)
end