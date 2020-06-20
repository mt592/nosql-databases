#Your code goes here

import 'org.apache.hadoop.hbase.client.HTable'
import 'org.apache.hadoop.hbase.client.Put'

def jbytes( *args)
  args.map{ |arg| arg.to_s.to_java_bytes}
end

def put_many(table_name, row, column_values)
  #Code from class
  #table = HTable.new(@hbase.configuration, "wiki")
  #p=Put.new( *jbytes("Home"))
  #p.add(*jbytes("text", "", "Hello world"))
  #table.put(p)
  #where "Home" is the row, "text" is the column family, "" is the column qualifier, and "Hello world" is the value


  table=HTable.new(@hbase.configuration, table_name)

  p=Put.new( *jbytes(row))


  column_values.each do |key, valuePair|
    (colFamily, colQual) = key.split(':')
    colQual ||= ""
    p.add( *jbytes(colFamily, colQual, valuePair))
  end
  table.put(p)
end


put_many 'wiki', "Ice cream sundaes", {
  "text:" => "Put chocolate syrup and a cherry on top of ice cream to make a sundae.",
  "revision:author" => "Michelle Turovsky",
  "revision:comment"=> "You can even add fruits"}

get 'wiki', 'Home'
get 'wiki', "Ice cream sundaes"


#Do not remove the exit call below
exit
