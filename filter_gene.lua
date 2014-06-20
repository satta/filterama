name        = "Coding Gene Filter"
author      = "Sascha Steinbiss"
version     = "1.0"
email       = "ss34@sanger.ac.uk"
short_descr = "Filters out CCs which are not protein coding genes."
description = "Filters out a CC if it is not a protein coding gene."

function filter(gn)
  gfi = gt.feature_node_iterator_new(gn)
  node = gfi:next()
  while node ~= nil do
    if (node:get_type() == "CDS") then
      return false
    end
    node = gfi:next()
  end
  return true
end
