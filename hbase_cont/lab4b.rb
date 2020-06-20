#Your Jruby script code goes here
require 'time'

import 'org.apache.hadoop.hbase.client.HTable'
import 'org.apache.hadoop.hbase.client.Put'
import 'javax.xml.stream.XMLStreamConstants'

def jbytes( *args)
  args.map{ |arg| arg.to_s.to_java_bytes }
end

factory = javax.xml.stream.XMLInputFactory.newInstance
reader = factory.createXMLStreamReader(java.lang.System.in)

document = nil
buffer= nil
count = 0

table = HTable.new( @hbase.configuration, 'foods')
table.setAutoFlush(false)

while reader.has_next
  type = reader.next
  if type == XMLStreamConstants::START_ELEMENT
    case reader.local_name
    when 'Food_Display_Row' then document={}
    else buffer=[]
    end
  elsif type == XMLStreamConstants::CHARACTERS
    buffer << reader.text unless buffer.nil?
  elsif type == XMLStreamConstants::END_ELEMENT
    case reader.local_name
    #when /fact/ then document[reader.local_name] = buffer.join
    when 'Food_Display_Row' then
      key = document['Display_Name'].to_java_bytes
      p = Put.new(key)
      p.add( *jbytes("fact", "Food_Code", document['Food_Code']))
      p.add( *jbytes("fact", "Display_Name", document['Display_Name']))
      p.add( *jbytes("fact", "Portion_Default", document['Portion_Default']))
      p.add( *jbytes("fact", "Portion_Amount", document['Portion_Amount']))
      p.add( *jbytes("fact", "Portion_Display_Name", document['Portion_Display_Name']))
      p.add( *jbytes("fact", "Factor", document['Factor']))
      p.add( *jbytes("fact", "Increment", document['Increment']))
      p.add( *jbytes("fact", "Multiplier", document['Multiplier']))
      p.add( *jbytes("fact", "Grains", document['Grains']))
      p.add( *jbytes("fact", "Whole_Grains", document['Whole_Grains']))
      p.add( *jbytes("fact", "Vegetables", document['Vegetables']))
      p.add( *jbytes("fact", "Orange_Vegetables", document['Orange_Vegetables']))
      p.add( *jbytes("fact", "Drkgreen_Vegetables", document['Drkgreen_Vegetables']))
      p.add( *jbytes("fact", "Starchy_vegetables", document['Starchy_vegetables']))
      p.add( *jbytes("fact", "Other_Vegetables", document['Other_Vegetables']))
      p.add( *jbytes("fact", "Fruits", document['Fruits']))
      p.add( *jbytes("fact", "Milk", document['Milk']))
      p.add( *jbytes("fact", "Meats", document['Meats']))
      p.add( *jbytes("fact", "Soy", document['Soy']))
      p.add( *jbytes("fact", "Drybeans_Peas", document['Drybeans_Peas']))
      p.add( *jbytes("fact", "Oils", document['Oils']))
      p.add( *jbytes("fact", "Solid_Fats", document['Solid_Fats']))
      p.add( *jbytes("fact", "Added_Sugars", document['Added_Sugars']))
      p.add( *jbytes("fact", "Alcohol", document['Alcohol']))
      p.add( *jbytes("fact", "Calories", document['Calories']))
      p.add( *jbytes("fact", "Saturated_Fats", document['Saturated_Fats']))



      table.put(p)
      count +=1
      table.flushCommits() if count % 10 ==0
      if count % 500 == 0 
        puts "#{count} records insereted (#{document['Food_Code']})"
      end
    else 
      document[reader.local_name] = buffer.join unless buffer.nil?
    end
   
  end
end
table.flushCommits()


#Do not remove the exit call below
exit
