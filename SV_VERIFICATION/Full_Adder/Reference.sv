class reference;

  function void expected_output(transaction tr);
    tr.sum   = (tr.a ^ tr.b ^ tr.cin);
    tr.carry = (tr.a & tr.b) | (tr.b & tr.cin) | (tr.a & tr.cin);
  endfunction

endclass
