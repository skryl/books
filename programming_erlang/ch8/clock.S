{module, clock}.  %% version = 0

{exports, [{module_info,0},{module_info,1},{start,2},{stop,0}]}.

{attributes, []}.

{labels, 16}.


{function, start, 2, 2}.
  {label,1}.
    {line,[{location,"clock.erl",4}]}.
    {func_info,{atom,clock},{atom,start},2}.
  {label,2}.
    {allocate,0,2}.
    {move,{x,1},{x,2}}.
    {move,{x,0},{x,1}}.
    {move,{x,2},{x,0}}.
    {make_fun2,{f,15},0,0,2}.
    {line,[{location,"clock.erl",5}]}.
    {call_ext,1,{extfunc,erlang,spawn,1}}.
    {move,{x,0},{x,1}}.
    {move,{atom,clock},{x,0}}.
    {line,[{location,"clock.erl",5}]}.
    {call_ext_last,2,{extfunc,erlang,register,2},0}.


{function, stop, 0, 4}.
  {label,3}.
    {line,[{location,"clock.erl",7}]}.
    {func_info,{atom,clock},{atom,stop},0}.
  {label,4}.
    {allocate,0,0}.
    {move,{atom,stop},{x,1}}.
    {move,{atom,clock},{x,0}}.
    {line,[{location,"clock.erl",7}]}.
    send.
    {deallocate,0}.
    return.


{function, tick, 2, 6}.
  {label,5}.
    {line,[{location,"clock.erl",9}]}.
    {func_info,{atom,clock},{atom,tick},2}.
  {label,6}.
    {allocate,2,2}.
    {move,{x,1},{y,0}}.
    {move,{x,0},{y,1}}.
    {line,[{location,"clock.erl",10}]}.
  {label,7}.
    {loop_rec,{f,9},{x,0}}.
    {test,is_eq_exact,{f,8},[{x,0},{atom,stop}]}.
    remove_message.
    {move,{atom,void},{x,0}}.
    {deallocate,2}.
    return.
  {label,8}.
    {loop_rec_end,{f,7}}.
  {label,9}.
    {wait_timeout,{f,7},{y,1}}.
    timeout.
    {move,{y,0},{x,0}}.
    {line,[{location,"clock.erl",13}]}.
    {call_fun,0}.
    {move,{y,0},{x,1}}.
    {move,{y,1},{x,0}}.
    {call_last,2,{f,6},2}.


{function, module_info, 0, 11}.
  {label,10}.
    {line,[]}.
    {func_info,{atom,clock},{atom,module_info},0}.
  {label,11}.
    {move,{atom,clock},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 13}.
  {label,12}.
    {line,[]}.
    {func_info,{atom,clock},{atom,module_info},1}.
  {label,13}.
    {move,{x,0},{x,1}}.
    {move,{atom,clock},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.


{function, '-start/2-fun-0-', 2, 15}.
  {label,14}.
    {line,[{location,"clock.erl",5}]}.
    {func_info,{atom,clock},{atom,'-start/2-fun-0-'},2}.
  {label,15}.
    {move,{x,1},{x,2}}.
    {move,{x,0},{x,1}}.
    {move,{x,2},{x,0}}.
    {call_only,2,{f,6}}.
