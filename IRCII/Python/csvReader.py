import os
import math



def writeCsvDict(dict1, dict2):

    csv = "Samples,Vaginal,Cesarean\n"

    for key in dict1.keys():

        name = key.split(" ")[0]

        csv+=name+","+str(dict1[key])+","+str(dict2[key])+"\n"

    f = open("InfoGainEarly.csv", "w")
    f.write(csv)
    f.close()




def csvColumnsDict(filename):
    lines = open(filename).readlines()

    newLines = []
    for line in lines:
        line = line.replace("\"", "")
        newLines.append(line.split(","))


    cSecCount = 0
    vCount = 0

    for i in range(1,len(newLines)):
        if newLines[i][2] == "Cesarean":
            cSecCount+=1
        elif newLines[i][2] == "Vaginal":
            vCount+=1

    cSecDict = {}
    vDict = {}

    for i in range(3, len(newLines[0])):

        cSecValue = []
        for j in range(cSecCount):
            cSecValue.append(newLines[j+1][i].strip())
        cSecDict[newLines[0][i]] = cSecValue

        vValue = []
        for j in range(vCount):
            vValue.append(newLines[j+cSecCount+1][i].strip())
        vDict[newLines[0][i]] = vValue

    return cSecDict, vDict


def entropy(countList):

    h = 0
    for v in countList:
        p = v / sum(countList)
        if p != 0:
            h += -p*(math.log2(p))
    return h/math.log2(2)





if __name__ == '__main__':

    dict = csvColumnsDict("Early_ordered.csv")


    keys = dict[0].keys()


    cT = {}
    vT = {}
    tT = {}
    cF = {}
    vF = {}
    tF = {}

    cEnt = {}
    vEnt = {}
    tEnt = {}

    cIg = {}
    vIg = {}


    for key in keys:
        cT[key] = 0
        vT[key] = 0
        tT[key] = 0
        cF[key] = 0
        vF[key] = 0
        tF[key] = 0

        cVals = dict[0][key]
        vVals = dict[1][key]


        for val in cVals:

            if val == "TRUE":
                cT[key] += 1
                tT[key] += 1
            elif val == "FALSE":
                cF[key] += 1
                tF[key] += 1

        for val in vVals:

            if val == "TRUE":
                vT[key] += 1
                tT[key] += 1
            elif val == "FALSE":
                vF[key] += 1
                tF[key] += 1






        cEnt[key] = entropy([cT[key], cF[key]])
        vEnt[key] = entropy([vT[key], vF[key]])
        tEnt[key] = entropy([tT[key], tF[key]])

        cIg[key] = 1 - cEnt[key]
        vIg[key] = 1 - vEnt[key]






    sortedCIg = sorted(cIg, key = lambda k: cIg[k], reverse = True)
    sortedVIg = sorted(vIg, key = lambda k: vIg[k], reverse=True)




    writeCsvDict(vIg, cIg)