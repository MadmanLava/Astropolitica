if(typing and priorPos != ds_list_size(priorInputs) and ds_list_size(priorInputs) > 0)
{
priorPos = priorPos + 1;
keyboard_string = ds_list_find_value(priorInputs, priorPos)
}