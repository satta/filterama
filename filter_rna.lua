function filter(gn)
  gfi = gt.feature_node_iterator_new(gn)
  node = gfi:next()
  while node ~= nil do
    if (node:get_type() == "rRNA") then
      return false
    end
    node = gfi:next()
  end
  return true
end
