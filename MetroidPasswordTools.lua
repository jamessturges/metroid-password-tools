bitToggleBuffer = 0
itemHistoryStart = 0x6887
itemHistoryEnd = 0x68FC
password = ""
passwordByteArray = {}
passwordFrozen = false

function printInfo()

  mainGame = getCpuByte(0x1D) == 0

  currentStrYPos = 0
 
 addressTableDrawXOffset = 208
 
 addressTable = buildAddressTable(addressTable)

  -- cannot be a multiple of 16
  canGeneratePassword = not(addressTable[17][1]["val"] == 1 or 
  				      addressTable[17][2]["val"] == 1 or
  				      addressTable[17][3]["val"] == 1 or
  				      addressTable[17][4]["val"] == 1) and not passwordFrozen and mainGame
  				      
 if canGeneratePassword then
   password = calculatePassword()
 end

 commandYOffset = 50
 
 drawString(0, 0, (string.len(password) > 0 and "Password\n" or "") .. password, true)
 
 if mainGame then
  drawString(0, commandYOffset, (passwordFrozen and "Unfreeze" or "Freeze"), true)
  drawAddressTable(addressTable)
 elseif string.len(password) > 0 then
  drawString(0, commandYOffset, "Enter", true)
 end


 handleMouse()
end

function buildAddressTable()
  addressTable = {}
  
  memoryValHash = {}
  itemHistory = getItemHistory()

  
  -- items 0-7
  passwordByte00 = addAddressTableRow(addressTable) 
  setAddressTableCellForItem(passwordByte00, 8, 0x104E, "Maru Mari")
  setAddressTableCellForItem(passwordByte00, 7, 0x264B, "Missliles 12,0B")
  setAddressTableCellForItem(passwordByte00, 6, 0x28E5, "R Door Long Beam")
  setAddressTableCellForItem(passwordByte00, 5, 0x2882, "R Door Tourian Elev")
  setAddressTableCellForItem(passwordByte00, 4, 0x2327, "ETank 19,07")
  setAddressTableCellForItem(passwordByte00, 3, 0x2B25, "R Door Bombs")
  setAddressTableCellForItem(passwordByte00, 2, 0x0325, "Bombs")
  setAddressTableCellForItem(passwordByte00, 1, 0x2A69, "R Door IceBeam 13,09")
  
  -- items 8-15
  passwordByte01 = addAddressTableRow(addressTable)  
  setAddressTableCellForItem(passwordByte01, 8, 0x2703, "Missiles 18,03")
  setAddressTableCellForItem(passwordByte01, 7, 0x2363, "E Tank")
  setAddressTableCellForItem(passwordByte01, 6, 0x29E2, "R Door Varia")
  setAddressTableCellForItem(passwordByte01, 5, 0x15E2, "Varia Suit")
  setAddressTableCellForItem(passwordByte01, 4, 0x212E, "ETank 09,0E")
  setAddressTableCellForItem(passwordByte01, 3, 0x264E, "Missiles 12,0E")
  setAddressTableCellForItem(passwordByte01, 2, 0x262F, "Missiles 11,0F")
  setAddressTableCellForItem(passwordByte01, 1, 0x2B4C, "R Door IceBeam 1B,0C")
  
  -- items 16-23
  passwordByte02 = addAddressTableRow(addressTable) 
  setAddressTableCellForItem(passwordByte02, 8, 0x276A, "Missiles 1B,0A")
  setAddressTableCellForItem(passwordByte02, 7, 0x278A, "Missiles 1C,0A")
  setAddressTableCellForItem(passwordByte02, 6, 0x278B, "Missiles 1C,0B")
  setAddressTableCellForItem(passwordByte02, 5, 0x276B, "Missiles 1B,0B")
  setAddressTableCellForItem(passwordByte02, 4, 0x274B, "Missiles 1A,0B")
  setAddressTableCellForItem(passwordByte02, 3, 0x268F, "Missiles 14,0F")
  setAddressTableCellForItem(passwordByte02, 2, 0x266F, "Missiles 13,0F")
  setAddressTableCellForItem(passwordByte02, 1, 0x2B71, "R Door HighJump 1C,11")
  
  -- items 24-31
  passwordByte03 = addAddressTableRow(addressTable) 
  setAddressTableCellForItem(passwordByte03, 8, 0x0771, "High Jump 1B,11")
  setAddressTableCellForItem(passwordByte03, 7, 0x29F0, "R Door Screw Attack")
  setAddressTableCellForItem(passwordByte03, 6, 0x0DF0, "Screw Attack")
  setAddressTableCellForItem(passwordByte03, 5, 0x2676, "Missiles 13,16")
  setAddressTableCellForItem(passwordByte03, 4, 0x2696, "Missiles 14,16")
  setAddressTableCellForItem(passwordByte03, 3, 0x2A55, "R Door Wave Beam")
  setAddressTableCellForItem(passwordByte03, 2, 0x2353, "ETank 1A,13")
  setAddressTableCellForItem(passwordByte03, 1, 0x2794, "Missiles 1C,14")
  
  -- items 32-39
  passwordByte04 = addAddressTableRow(addressTable) 
  setAddressTableCellForItem(passwordByte04, 8, 0x28F5, "R Door 07,15")
  setAddressTableCellForItem(passwordByte04, 7, 0x2535, "Missiles 09,15")
  setAddressTableCellForItem(passwordByte04, 6, 0x2495, "Missiles 04,15")
  setAddressTableCellForItem(passwordByte04, 5, 0x28F6, "R Door 07,16")
  setAddressTableCellForItem(passwordByte04, 4, 0x2156, "ETank 0A,16")
  setAddressTableCellForItem(passwordByte04, 3, 0x28F8, "R Door 07,18")
  setAddressTableCellForItem(passwordByte04, 2, 0x287B, "R Door 03,1B")
  setAddressTableCellForItem(passwordByte04, 1, 0x24BB, "R Missiles 05,1B")
  
  -- items 40-47
  passwordByte05 = addAddressTableRow(addressTable) 
  setAddressTableCellForItem(passwordByte05, 8, 0x2559, "Missiles 0A,19")
  setAddressTableCellForItem(passwordByte05, 7, 0x291D, "R Door Kraid 08,1D")
  setAddressTableCellForItem(passwordByte05, 6, 0x211D, "ETank Kraid 08,1D")
  setAddressTableCellForItem(passwordByte05, 5, 0x2658, "Missiles 12,18")
  setAddressTableCellForItem(passwordByte05, 4, 0x2A39, "R Door 11,19")
  setAddressTableCellForItem(passwordByte05, 3, 0x2239, "ETank 11,19")
  setAddressTableCellForItem(passwordByte05, 2, 0x269E, "Missiles 14,1E")
  setAddressTableCellForItem(passwordByte05, 1, 0x2A1D, "P Door 10,1D")
  
  -- items 48-55
  passwordByte06 = addAddressTableRow(addressTable) 
  setAddressTableCellForItem(passwordByte06, 8, 0x21FD, "ETank 0F,1D")
  setAddressTableCellForItem(passwordByte06, 7, 0x271B, "Missile 18,1B")
  setAddressTableCellForItem(passwordByte06, 6, 0x2867, "O Door 03,07")
  setAddressTableCellForItem(passwordByte06, 5, 0x2927, "R Door 09,07")
  setAddressTableCellForItem(passwordByte06, 4, 0x292B, "R Door 0A,0B")
  setAddressTableCellForItem(passwordByte06, 3, 0x3C00, "Zebetite #1")
  setAddressTableCellForItem(passwordByte06, 2, 0x4000, "Zebetite #2")
  setAddressTableCellForItem(passwordByte06, 1, 0x4400, "Zebetite #3")
  
  -- items 56-58
  passwordByte07 = addAddressTableRow(addressTable) 
  setAddressTableCellForItem(passwordByte07, 8, 0x4800, "Zebetite #4")
  setAddressTableCellForItem(passwordByte07, 7, 0x4C00, "Zebetite #5")
  setAddressTableCellForItem(passwordByte07, 6, 0x3800, "MB Defeated")
  
  -- start location & suit status
  passwordByte08 = addAddressTableRow(addressTable) 
  setAddressTableCellFromAddress(passwordByte08, 1, 0x69B3, 1, "ZeroSuit")
  
  setAddressTableCellFromAddress(passwordByte08, 3, 0x0074, 5, "InArea (unknown use")
  setAddressTableCellFromAddress(passwordByte08, 4, 0x0074, 4, "InArea (unknown use")
  setAddressTableCellFromAddress(passwordByte08, 5, 0x0074, 3, "ResetBit")
  setAddressTableCellFromAddress(passwordByte08, 6, 0x0074, 2, "InArea")
  setAddressTableCellFromAddress(passwordByte08, 7, 0x0074, 1, "InArea")
  setAddressTableCellFromAddress(passwordByte08, 8, 0x0074, 0, "InArea")
  
  -- Samus's gear
  passwordByte09 = addAddressTableRowFromAddress(addressTable, 0x6878, {"Ice Beam", "Wave Beam", "Varia", "Maru Mari", "Screw Attack", "Long Beam", "High Jump", "Bombs"})
  
  -- Missles
  passwordByte0A = addAddressTableRowFromAddress(addressTable, 0x6879, {"Missles"})
  
  -- Low byte of game age
  passwordByte0B = addAddressTableRowFromAddress(addressTable, 0x687D, {"Age Low Byte"})
    
  -- Mid byte of game agev
  passwordByte0D = addAddressTableRowFromAddress(addressTable, 0x687E, {"Age Mid Byte"})

  
  -- High byte of game age
  passwordByte0C = addAddressTableRowFromAddress(addressTable, 0x687F, {"Age High Byte"})  
  
  -- Unused
  passwordByte0E = addAddressTableRow(addressTable)
  
  -- Statue status
  passwordByte0F = addAddressTableRow(addressTable)
  setAddressTableCellFromAddress(passwordByte0F, 1, 0x687B, 7, "Kraid Statue Up")
  setAddressTableCellFromAddress(passwordByte0F, 2, 0x687B, 0, "Kraid Statue Blink")
  setAddressTableCellFromAddress(passwordByte0F, 3, 0x687C, 7, "Ridley Statue Up")
  setAddressTableCellFromAddress(passwordByte0F, 4, 0x687C, 0, "Ridley Statue Blink")
  
  -- Shift byte (random number)
  passwordByte10 = addAddressTableRowFromAddress(addressTable, 0x2E, {"RNG"})
  
  -- Checksum (sum of 00 thru 10)
  passwordByte11 = addAddressTableRow(addressTable)
  
  checkSum = calculateCheckSum()
  for i=1,9 do
    setAddressTableCell(passwordByte11, i, 0, 8 - i, checkSum[i], "CheckSum")
  end
  
  --narpassword = addAddressTableRowFromAddress(addressTable, 0x69B2, {"NARPASSWORD"})
  
  return addressTable
end

function addAddressTableRowFromAddress(addressTable, address, desc)
  
  valAsBitArray = numberToBitArray(getCpuByte(address))
  
  currentRow = addAddressTableRow(addressTable)

  setAddressTableCells(currentRow, address, bitArray, desc)

  return currentRow
end

function addAddressTableRow(addressTable)

 addressTable[#addressTable+1] = {}
 row =  addressTable[#addressTable]
   
  for i=1,9 do
    setAddressTableCell(row, i, 0, 0, 0, "unused")
  end
  
  return row
end

function setAddressTableCells(row, address, bitArray, desc)

  useDescAsArray = #desc > 1
  for index, bit in ipairs(bitArray) do
    setAddressTableCell(row, index, address, 8 - index, bit, (useDescAsArray and desc[index] or desc[1]))
  end
end

function setAddressTableCellFromAddress(row, col, address, bit, desc)

  memoryVal = {}
  
  if memoryValHash[address] then
    memoryVal = memoryValHash[address]
  else
    memoryVal = numberToBitArray(getCpuByte(address))
    memoryValHash[address] = memoryVal
  end

  memoryValBit = getBit(memoryVal, bit)
  
  setAddressTableCell(row, col, address, bit, memoryValBit, desc)
end 

function setAddressTableCellForItem(row, col, item, desc)
  hasItem = itemHistory[string.format("%02X", item)] or 0
  setAddressTableCell(row, col, item, 0, hasItem, desc, true)
end 

function setAddressTableCell(row, col, address, bit, val, desc, isItem)
  row[col] = {address = address, 
  			bit = bit, 
  			val = val,
  			desc = desc,
  			isItem = isItem}
end 

function drawAddressTable(addressTable)
  for rowIndex, row in ipairs(addressTable) do
    rowVals = {}
    for colIndex, col in ipairs(row) do
      rowVals[colIndex] = col["val"]
    end
    
    rowValsString = tableToString(rowVals)
    drawVal(rowValsString)
  end
end

function getItemHistory()
  itemHistory = {}
  
  for i=itemHistoryStart,itemHistoryEnd,2 do
    itemHighByte = getCpuByte(i)
    itemLowByte = getCpuByte(i+1)
    
    itemHex = string.format("%02X", itemLowByte) .. string.format("%02X", itemHighByte)
    
    if itemHex ~= "0000" then
      itemHistory[itemHex] = 1
    end
  end
  
  return itemHistory
end

function getCpuByte(address)
  return emu.read(address, emu.memType.nesDebug)
end

function getCpuWord(address)
  return emu.readWord(adddress, emu.memType.nesDebug)
end

function setCpuByte(address, val)
  emu.write(address, val, emu.memType.nesDebug)
end

function setPpuByte(address, val)
  emu.write(address, val, emu.memType.nesPpuDebug)
end

function drawVal(text)
 drawString(addressTableDrawXOffset, currentStrYPos, text)
 currentStrYPos = currentStrYPos + 10
end

function tableToString(tbl)
  str = ""
  
  for _, value in ipairs(tbl) do
    str = str .. value
  end
  
  return str
end

function drawString(x, y, text, withBackground)
 if withBackground then
  emu.drawString(x, y, text, 0xFFFFFF, bgColor or 0x00000000)
 else
  emu.drawString(x, y, text, 0xFFFFFF, bgColor or 0xFF000000)
 end
end

function handleMouse()
  mouseState = emu.getMouseState()  

 addressTableRowIndex = math.floor(mouseState.y / 10) + 1

 addressTableRow = addressTable[addressTableRowIndex]
 text = ""
 if(addressTableRow) then
    addressTableColIndex = math.floor((mouseState.x - addressTableDrawXOffset) / 6) + 1
    addressTableCell = addressTableRow[addressTableColIndex]
    

    if(addressTableCell) then
      isItem = addressTableCell["isItem"]
      text = addressTableCell["desc"] ..
             "\n" .. (isItem and "Item:" or "0x") .. string.format("%X", addressTableCell["address"]) ..
             (isItem and "" or "\nBit:" .. addressTableCell["bit"]) ..
             "\nVal:" .. addressTableCell["val"] 
             
             
      if handleClick()  then
        toggleBit(addressTableCell)
        didClick()
      end
    end
  end
  
  if(text ~= "") then
    drawString(mouseState.x - 75 , mouseState.y, text, true)
  end 
  
  if mouseState.x < 50 and mouseState.y >= commandYOffset and mouseState.y <= commandYOffset+10  and handleClick() then 
    if mainGame then
      passwordFrozen = not passwordFrozen
    else
      enterPassword()
    end
    
    
    didClick()
  end
  
  if(bitToggleBuffer) > 0 then
    bitToggleBuffer = bitToggleBuffer - 1
  end
end

function handleClick()
  return mouseState.left == true and bitToggleBuffer == 0
end

function didClick()
  bitToggleBuffer = 15
end

function toggleBit(cell)
  cellAddress = cell["address"]
  cellBit = cell["bit"]
  cellVal = cell["val"]
  cellIsItem = cell["isItem"]
  
  newCellVal = cellVal == 1 and 0 or 1
  
  if cellIsItem then
    if newCellVal == 1 then
      addItem(cellAddress)
    else
      removeItem(cellAddress)
    end
  else
    memoryVal = getCpuByte(cellAddress)
    memoryValBitArray = numberToBitArray(memoryVal)
  
    setBit(memoryValBitArray, cellBit, newCellVal)
    setCpuByte(cellAddress, bitArrayToNumber(memoryValBitArray))
  end

end

function addItem(item)
  itemHistory[string.format("%02X", item)] = true
  updateItemHistory()
end

function removeItem(item)
  itemHistory[string.format("%02X", item)] = nil
  updateItemHistory()
end

function updateItemHistory()
  for i=itemHistoryStart,itemHistoryEnd do
    setCpuByte(i, 0)
  end
  
  itemHistoryOffset = itemHistoryStart
  drawVal(itemHistoryOffset)
  itemCount = 0
  for item, _ in pairs(itemHistory) do
    setCpuByte(itemHistoryOffset, tonumber(string.sub(item, 3, 4), 16))
    setCpuByte(itemHistoryOffset+1, tonumber(string.sub(item, 1, 2), 16))
    
    itemHistoryOffset = itemHistoryOffset + 2
    itemCount = itemCount + 1
  end
  
  setCpuByte(itemHistoryStart-1, itemCount*2)
end

function enterPassword()
  passwordCharOffset = 0x699A
  ppuLine1Offset = 0x2109
  
  for i=0,23 do
    passwordByte = passwordByteArray[i+1]
    setCpuByte(passwordCharOffset+i, passwordByte)
    
    ppuOffset = ppuLine1Offset + i
    if (i > 5 and i < 12) or (i > 17)  then
      ppuOffset = ppuOffset + 1
    end
    
    if i > 11 then
      ppuOffset = ppuOffset + 52
    end
    
    setPpuByte(ppuOffset, passwordByte)
  end
end

function calculateCheckSum()
  checkSum = 0
  
  for i=17,1,-1 do
    bitArray = {}
    for j=1,8 do
      bitArray[j] = addressTable[i][j]["val"]
    end
    
    checkSum = math.floor((checkSum + bitArrayToNumber(bitArray)) % 256)
  end
  
  return numberToBitArray(checkSum)
end

function calculatePassword()
  
  alphabet = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "?", "-"}
  
  passwordString = ""
  
  memoryString = ""
  
  -- concat all address values
  for i=1,18 do
    for j=1,8 do
      memoryString = memoryString .. addressTable[i][j]["val"]
    end
  end
  
  -- right shift however many times password byte 10 defines
  shiftByteArray = {}
  for i=1,8 do
   shiftByteArray[i] = addressTable[17][i]["val"]
  end

  shiftByteNumber = bitArrayToNumber(shiftByteArray) 

  payloadLen = 128
  
  memoryStringPayload = string.sub(memoryString, 1, payloadLen)
  memoryStringRemainder = string.sub(memoryString, payloadLen+1, string.len(memoryString))
  
  while shiftByteNumber > 0 do
    lastChar = string.sub(memoryStringPayload, payloadLen, payloadLen)
    otherChars = string.sub(memoryStringPayload, 1, payloadLen-1)
    memoryStringPayload = lastChar .. otherChars
    shiftByteNumber = shiftByteNumber - 1
  end
  
  memoryString = memoryStringPayload .. memoryStringRemainder

  passwordByteArray = {}
  for i=1, string.len(memoryString), 6 do
    passwordSubstring = string.sub(memoryString, i, i+5)
    passwordByte = tonumber(passwordSubstring, 2) 
    passwordChar = alphabet[passwordByte + 1]
    passwordString = passwordString .. passwordChar
    passwordByteArray[#passwordByteArray + 1] = passwordByte
  end
  
  passwordString = string.sub(passwordString, 1, 6) .. "\n" 
    				.. string.sub(passwordString, 7, 12) .. "\n" 
    				.. string.sub(passwordString, 13, 18) .. "\n"
    				.. string.sub(passwordString, 19, 24)
    				
  return passwordString
end

function numberToBitArray(x)
	bitArray = {0,0,0,0,0,0,0,0}
	arrayPos = 8
	while arrayPos > 0 do
		bitArray[arrayPos] = x%2
		x=math.modf(x/2)
		arrayPos = arrayPos - 1
	end

	return bitArray
end

function bitArrayToNumber(bitArray)
  num = 0;
  
  multiplier = 128
  
  for index, value in ipairs(bitArray) do
    if value == 1 then
      num = num + multiplier
    end
    
    multiplier = multiplier / 2
  end
  
  return math.floor(num)
end

function getBit(bitArray, bit)
  return bitArray[8-bit]
end

function setBit(bitArray, bit, val)
  bitArray[8-bit] = val
end

emu.addEventCallback(printInfo, emu.eventType.endFrame);