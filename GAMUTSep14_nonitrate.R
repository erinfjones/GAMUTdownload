### iUTAH GAMUT Aquatic Station 
###    Grab Sample download
### Version 1.1
### Written by: Erin Fleming Jones, contact at erinfjones3@gmail.com
### Last updated: 4/23/2017
setwd("~/Box Sync/BYU/metagenomics")



####NOTES: Check ARBR gage code


## Load packages ##
library("devtools")
library("plyr")
Sys.timezone()
library("WaterML")
## Data server connections ##

# services = GetServices()  ##Lists URLs of all available datasets
Loganserver= 'http://data.iutahepscor.org/LoganRiverWOF/cuahsi_1_1.asmx?WSDL'  ##Conects to each web database
RBserver= 'http://data.iutahepscor.org/RedButteCreekWOF/cuahsi_1_1.asmx?WSDL'
PRserver= 'http://data.iutahepscor.org/ProvoRiverWOF/cuahsi_1_1.asmx?WSDL'


variables=GetVariables(RBserver) ##Lists variable codes
Logansites= GetSites(Loganserver)  ##Lists site codes
Provosites= GetSites(PRserver)
RBsites= GetSites(RBserver)

### Set Date and times ###

### Logan ctrl F: 4Sep
LRStartDate = "2014-09-04"          ##yyyy-mm-dd format
LREndDate = "2014-09-05"
LR_FB_BADateTime= "2014-09-04 12:00:00"  ##yyyy-mm-dd hh:mm:ss format, rounded to 0, 15, 30, or 45 minute mark
LR_TG_BADateTime = "2014-09-04 12:00:00"
LR_WaterLab_AADateTime = "2014-09-04 12:00:00"
LR_MainStreet_BADateTime = "2014-09-04 14:45:00"
LR_Mendon_AADateTime = "2014-09-04 11:15:00"

### Red Butte ctrl F: 1Sep 
RBStartDate = "2014-09-01"          ##yyyy-mm-dd format
RBEndDate = "2014-09-02"  
RB_KF_BADateTime = "2014-09-0114:15:00"   ##yyyy-mm-dd hh:mm:ss format, rounded to 0, 15, 30, or 45 minute mark
RB_ARBR_AADateTime = "2014-09-01 14:00:00"
RB_RBG_BADateTime = "2014-09-01 11:30:00"
RB_CG_BADateTime = "2014-09-01 14:15:00"
RB_FD_AADateTime = "2014-09-01 14:15:00"

### Provo ctrl F: 3Sep
PRStartDate = "2014-09-03"          ##yyyy-mm-dd format 
PREndDate ="2014-09-04" 
PR_ST_BADateTime = "2014-09-03 12:30:00"  ##yyyy-mm-dd hh:mm:ss format, rounded to 0, 15, 30, or 45 minute mark
PR_BJ_AADateTime = "2014-09-03 15:00:00"  ## must be rounded to on the hour e.g. 14:00:00
PR_LM_BADateTime = "2014-09-03 11:00:00"  ## must be rounded to on the hour e.g. 14:00:00
PR_CH_AADateTime = "2014-09-03 13:00:00"  ## must be rounded to on the hour e.g. 14:00:00

  
# Q- PR_BJ, PR_LM, PR_CH only available on the hour (for now)
 

##### Franklin Basin ####
 

##Franklin Basin Water Temp##
#exo_Temp
EXWTempFranklin<- GetValues(Loganserver, siteCode="iutah:LR_FB_BA", variableCode="iutah:WaterTemp_EXO", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )   #Download 24 hrs
EXWTempFranklin = subset(EXWTempFranklin[ which(EXWTempFranklin$time == LR_FB_BADateTime),] )    ### Subset 24-hr for single time point
EXWTempFranklin$DataValue[EXWTempFranklin$DataValue==-9999.00] <- NA                             ### Substitute database NA for R NA
#Turbidity_Temp
TWTempFranklin<- GetValues(Loganserver, siteCode="iutah:LR_FB_BA", variableCode="iutah:WaterTemp_Turb", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
TWTempFranklin <- subset(TWTempFranklin[ which(TWTempFranklin$time == LR_FB_BADateTime),])
TWTempFranklin$DataValue[TWTempFranklin$DataValue==-9999.00] <- NA

##Franklin Basin pH##
pHFranklin<- GetValues(Loganserver, siteCode="iutah:LR_FB_BA", variableCode="iutah:pH", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
pHFranklin = subset(pHFranklin[ which(pHFranklin$time == LR_FB_BADateTime),] )
pHFranklin$DataValue[pHFranklin$DataValue==-9999.00] <- NA

##Franklin Basin Specific Conductivity##
SpConFranklin<- GetValues(Loganserver, siteCode="iutah:LR_FB_BA", variableCode="iutah:SpCond", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
SpConFranklin = subset(SpConFranklin[ which(SpConFranklin$time == LR_FB_BADateTime),] )
SpConFranklin$DataValue[SpConFranklin$DataValue==-9999.00] <- NA

##Franklin Basin Dissolved Oxygen##
ODOFranklin<-GetValues(Loganserver, siteCode="iutah:LR_FB_BA", variableCode="iutah:ODO", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
ODOFranklin = subset(ODOFranklin[ which(ODOFranklin$time == LR_FB_BADateTime),] )
ODOFranklin$DataValue[ODOFranklin$DataValue==-9999.00] <- NA

##Franklin Basin Specific Turbidity##
TurbFranklin<- GetValues(Loganserver, siteCode="iutah:LR_FB_BA", variableCode="iutah:TurbAvg", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
TurbFranklin = subset(TurbFranklin[ which(TurbFranklin$time == LR_FB_BADateTime),] )
TurbFranklin$DataValue[TurbFranklin$DataValue==-9999.00] <- NA

##Franklin Basin Gage##
GageFranklin<- GetValues(Loganserver, siteCode="iutah:LR_FB_BA", variableCode="iutah:Stage", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
GageFranklin = subset(GageFranklin[ which(GageFranklin$time == LR_FB_BADateTime),] )
GageFranklin$DataValue[GageFranklin$DataValue==-9999.00] <- NA


##### Tony Grove ####


##Tony Grove Water Temp##
#exo_Temp
EXWTempTonyGrove<- GetValues(Loganserver, siteCode="iutah:LR_TG_BA", variableCode="iutah:WaterTemp_EXO", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
EXWTempTonyGrove = subset(EXWTempTonyGrove[ which(EXWTempTonyGrove$time == LR_TG_BADateTime),] )
EXWTempTonyGrove$DataValue[EXWTempTonyGrove$DataValue==-9999.00] <- NA

#Turbidity_Temp
TWTempTonyGrove<-  GetValues(Loganserver, siteCode="iutah:LR_TG_BA", variableCode="iutah:WaterTemp_Turb", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
TWTempTonyGrove = subset(TWTempTonyGrove[ which(TWTempTonyGrove$time == LR_TG_BADateTime),] )
TWTempTonyGrove$DataValue[TWTempTonyGrove$DataValue==-9999.00] <- NA

##Tony Grove pH##
pHTonyGrove<-  GetValues(Loganserver, siteCode="iutah:LR_TG_BA", variableCode="iutah:pH", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
pHTonyGrove = subset(pHTonyGrove[ which(pHTonyGrove$time == LR_TG_BADateTime),] )
pHTonyGrove$DataValue[pHTonyGrove$DataValue==-9999.00] <- NA


##Tony Grove Specific Conductivity##
SpConTonyGrove<-  GetValues(Loganserver, siteCode="iutah:LR_TG_BA", variableCode="iutah:SpCond", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
SpConTonyGrove = subset(SpConTonyGrove[ which(SpConTonyGrove$time == LR_TG_BADateTime),] )
SpConTonyGrove$DataValue[SpConTonyGrove$DataValue==-9999.00] <- NA


##Tony Grove Dissolved Oxygen##
ODOTonyGrove<-  GetValues(Loganserver, siteCode="iutah:LR_TG_BA", variableCode="iutah:ODO", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
ODOTonyGrove = subset(ODOTonyGrove[ which(ODOTonyGrove$time == LR_TG_BADateTime),] )
ODOTonyGrove$DataValue[ODOTonyGrove$DataValue==-9999.00] <- NA


##Tony Grove Specific Turbidity##
TurbTonyGrove<-  GetValues(Loganserver, siteCode="iutah:LR_TG_BA", variableCode="iutah:TurbAvg", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
TurbTonyGrove = subset(TurbTonyGrove[ which(TurbTonyGrove$time == LR_TG_BADateTime),] )
TurbTonyGrove$DataValue[TurbTonyGrove$DataValue==-9999.00] <- NA


##Tony Grove Discharge (Gage)##
GageTonyGrove<-  GetValues(Loganserver, siteCode="iutah:LR_TG_BA", variableCode="iutah:Stage", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
GageTonyGrove = subset(GageTonyGrove[ which(GageTonyGrove$time == LR_TG_BADateTime),] )
GageTonyGrove$DataValue[GageTonyGrove$DataValue==-9999.00] <- NA


##### Water Lab advanced ####


##Water Lab Water Temperature##
#exo_Temp
EXWTempWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:WaterTemp_EXO", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
EXWTempWaterLab = subset(EXWTempWaterLab[ which(EXWTempWaterLab$time == LR_WaterLab_AADateTime),] )
EXWTempWaterLab$DataValue[EXWTempWaterLab$DataValue==-9999.00] <- NA #Converts -9999.0 to NA
#Turbidity_Temp
TWTempWaterLab = GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:WaterTemp_Turb", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
TWTempWaterLab = subset(TWTempWaterLab[ which(TWTempWaterLab$time == LR_WaterLab_AADateTime),] )
TWTempWaterLab$DataValue[TWTempWaterLab$DataValue==-9999.00] <- NA


##Water Lab pH##
pHWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:pH", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
pHWaterLab = subset(pHWaterLab[ which(pHWaterLab$time == LR_WaterLab_AADateTime),] )
pHWaterLab$DataValue[pHWaterLab$DataValue==-9999.00] <- NA


##Water Lab Specific Conductivity##
SpConWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:SpCond", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
SpConWaterLab = subset(SpConWaterLab[ which(SpConWaterLab$time == LR_WaterLab_AADateTime),] )
SpConWaterLab$DataValue[SpConWaterLab$DataValue==-9999.00] <- NA


##Water Lab Dissolved Oxygen##
ODOWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:ODO", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
ODOWaterLab = subset(ODOWaterLab[ which(ODOWaterLab$time == LR_WaterLab_AADateTime),] )
ODOWaterLab$DataValue[ODOWaterLab$DataValue==-9999.00] <- NA


##Water Lab Specific Tubidity##
TurbWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:TurbAvg", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
TurbWaterLab = subset(TurbWaterLab[ which(TurbWaterLab$time == LR_WaterLab_AADateTime),] )
TurbWaterLab$DataValue[TurbWaterLab$DataValue==-9999.00] <- NA


##Water Lab fDOM##
fDOMWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:fDOM", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
fDOMWaterLab = subset(fDOMWaterLab[ which(fDOMWaterLab$time == LR_WaterLab_AADateTime),] )
fDOMWaterLab$DataValue[fDOMWaterLab$DataValue==-9999.00] <- NA


##Water Lab Chla##
chlaWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:chlorophyll", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
chlaWaterLab = subset(chlaWaterLab[ which(chlaWaterLab$time == LR_WaterLab_AADateTime),] )
chlaWaterLab$DataValue[chlaWaterLab$DataValue==-9999.00] <- NA


##Water Lab Blue Green Algae (BGA)##
BGAWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:BGA", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
BGAWaterLab = subset(BGAWaterLab[ which(BGAWaterLab$time == LR_WaterLab_AADateTime),] )
BGAWaterLab$DataValue[BGAWaterLab$DataValue==-9999.00] <- NA


# ##Water Lab Nitrate##
# NitrateWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:Nitrate-N", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
# NitrateWaterLab = subset(NitrateWaterLab[ which(NitrateWaterLab$time == LR_WaterLab_AADateTime),] )
# NitrateWaterLab$DataValue[NitrateWaterLab$DataValue==-9999.00] <- NA


## Water Lab Gage height ##
GageWaterLab<- GetValues(Loganserver, siteCode="iutah:LR_WaterLab_AA", variableCode="iutah:Stage", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
GageWaterLab = subset(GageWaterLab[ which(GageWaterLab$time == LR_WaterLab_AADateTime),] )
GageWaterLab$DataValue[GageWaterLab$DataValue==-9999.00] <- NA


##### Main Street ####


##Main Street Water Temp##
#exo_Temp
EXWTempMainSt<- GetValues(Loganserver, siteCode="iutah:LR_MainStreet_BA", variableCode="iutah:WaterTemp_EXO", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
EXWTempMainSt = subset(EXWTempMainSt[ which(EXWTempMainSt$time == LR_MainStreet_BADateTime),] )
EXWTempMainSt$DataValue[EXWTempMainSt$DataValue==-9999.00] <- NA

#Turbidity_Temp
TWTempMainSt<- GetValues(Loganserver, siteCode="iutah:LR_MainStreet_BA", variableCode="iutah:WaterTemp_Turb", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
TWTempMainSt = subset(TWTempMainSt[ which(TWTempMainSt$time == LR_MainStreet_BADateTime),] )
TWTempMainSt$DataValue[TWTempMainSt$DataValue==-9999.00] <- NA


##Main Street pH##
pHMainSt<- GetValues(Loganserver, siteCode="iutah:LR_MainStreet_BA", variableCode="iutah:pH", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
pHMainSt = subset(pHMainSt[ which(pHMainSt$time == LR_MainStreet_BADateTime),] )
pHMainSt$DataValue[pHMainSt$DataValue==-9999.00] <- NA


##Main St Specific Conductivity##
SpConMainSt<- GetValues(Loganserver, siteCode="iutah:LR_MainStreet_BA", variableCode="iutah:SpCond", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
SpConMainSt = subset(SpConMainSt[ which(SpConMainSt$time == LR_MainStreet_BADateTime),] )
SpConMainSt$DataValue[SpConMainSt$DataValue==-9999.00] <- NA


##Main St Dissolved Oxygen##
ODOMainSt<- GetValues(Loganserver, siteCode="iutah:LR_MainStreet_BA", variableCode="iutah:ODO", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
ODOMainSt = subset(ODOMainSt[ which(ODOMainSt$time == LR_MainStreet_BADateTime),] )
ODOMainSt$DataValue[ODOMainSt$DataValue==-9999.00] <- NA


##Main St Specific Turbidity##
TurbMainSt<- GetValues(Loganserver, siteCode="iutah:LR_MainStreet_BA", variableCode="iutah:TurbAvg", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
TurbMainSt = subset(TurbMainSt[ which(TurbMainSt$time == LR_MainStreet_BADateTime),] )
TurbMainSt$DataValue[TurbMainSt$DataValue==-9999.00] <- NA


##Main Street Gage height##
GageMainSt<- GetValues(Loganserver, siteCode="iutah:LR_MainStreet_BA", variableCode="iutah:Stage", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
GageMainSt = subset(GageMainSt[ which(GageMainSt$time == LR_MainStreet_BADateTime),] )
GageMainSt$DataValue[GageMainSt$DataValue==-9999.00] <- NA


##### Mendon Rd advanced ####


##Mendon Rd Water Temp##
#exo_Temp
EXWTempMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:WaterTemp_EXO", startDate = LRStartDate, endDate = LREndDate, qcID = "0" )
EXWTempMendon = subset(EXWTempMendon[ which(EXWTempMendon$time == LR_Mendon_AADateTime),] )
EXWTempMendon$DataValue[EXWTempMendon$DataValue==-9999.00] <- NA
#Turbidity_Temp
TWTempMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:WaterTemp_Turb", startDate = LRStartDate, endDate = LREndDate, qcID = "0" )
TWTempMendon = subset(TWTempMendon[ which(TWTempMendon$time == LR_Mendon_AADateTime),] )
TWTempMendon$DataValue[TWTempMendon$DataValue==-9999.00] <- NA


##Mendon Rd pH##
pHMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:pH", startDate = LRStartDate, endDate = LREndDate, qcID = "0" )
pHMendon = subset(pHMendon[ which(pHMendon$time == LR_Mendon_AADateTime),] )
pHMendon$DataValue[pHMendon$DataValue==-9999.00] <- NA

##Mendon Rd Specific Conductivity##
SpConMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:SpCond", startDate = LRStartDate, endDate = LREndDate, qcID = "0" )
SpConMendon = subset(SpConMendon[ which(SpConMendon$time == LR_Mendon_AADateTime),] )
SpConMendon$DataValue[SpConMendon$DataValue==-9999.00] <- NA


##Mendon Rd Dissolved Oxygen##
ODOMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:ODO", startDate = LRStartDate, endDate = LREndDate, qcID = "0" )
ODOMendon = subset(ODOMendon[ which(ODOMendon$time == LR_Mendon_AADateTime),] )
ODOMendon$DataValue[ODOMendon$DataValue==-9999.00] <- NA


##Mendon Rd Turbidity##
TurbMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:TurbAvg", startDate = LRStartDate, endDate = LREndDate, qcID = "0" )
TurbMendon = subset(TurbMendon[ which(TurbMendon$time == LR_Mendon_AADateTime),] )
TurbMendon$DataValue[TurbMendon$DataValue==-9999.00] <- NA


##Mendon Rd fDOM##
fDOMMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:fDOM", startDate = LRStartDate, endDate = LREndDate, qcID = "0" )
fDOMMendon = subset(fDOMMendon[ which(fDOMMendon$time == LR_Mendon_AADateTime),] )
fDOMMendon$DataValue[fDOMMendon$DataValue==-9999.00] <- NA


##Mendon Rd Chla##
chlaMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:chlorophyll", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
chlaMendon = subset(chlaMendon[ which(chlaMendon$time == LR_Mendon_AADateTime),] )
chlaMendon$DataValue[chlaMendon$DataValue==-9999.00] <- NA


##Mendon Rd Blue Green Algea (BGA)##
BGAMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:BGA", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
BGAMendon = subset(BGAMendon[ which(BGAMendon$time == LR_Mendon_AADateTime),] )
BGAMendon$DataValue[BGAMendon$DataValue==-9999.00] <- NA


# ##Mendon Rd Nitrate##
# NitrateMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:Nitrate-N", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
# NitrateMendon = subset(NitrateMendon[ which(NitrateMendon$time == LR_Mendon_AADateTime),] )
# NitrateMendon$DataValue[NitrateMendon$DataValue==-9999.00] <- NA


##Mendon Rd Gage height##
GageMendon<- GetValues(Loganserver, siteCode="iutah:LR_Mendon_AA", variableCode="iutah:Stage", startDate = LRStartDate, endDate = LREndDate, qcID = "1" )
GageMendon = subset(GageMendon[ which(GageMendon$time == LR_Mendon_AADateTime),] )
GageMendon$DataValue[GageMendon$DataValue==-9999.00] <- NA


##### Logan Spreadsheet #####


Franklin4SepGrabSample <- data.frame(DateTime = EXWTempFranklin$time, 
                                    Site = "LR_FB_BA",
                                    Temp = EXWTempFranklin$DataValue,
                                    pH = pHFranklin$DataValue,
                                    SpCon = SpConFranklin$DataValue,
                                    ODO = ODOFranklin$DataValue,
                                    Turbidity = TurbFranklin$DataValue,
                                    Gage = GageFranklin$DataValue)
Franklin4SepGrabSample

TonyGrove4SepGrabSample <- data.frame(DateTime = EXWTempTonyGrove$time, 
                                    Site = "LR_TG_BA",
                                    Temp = EXWTempTonyGrove$DataValue,
                                    pH = pHTonyGrove$DataValue,
                                    SpCon = SpConTonyGrove$DataValue,
                                    ODO = ODOTonyGrove$DataValue,
                                    Turbidity = TurbTonyGrove$DataValue,
                                    Gage = GageTonyGrove$DataValue)
TonyGrove4SepGrabSample

WaterLab4SepGrabSample <- data.frame(DateTime = EXWTempWaterLab$time, 
                                    Site = "LR_WaterLab_AA",
                                    Temp = EXWTempWaterLab$DataValue,
                                    pH = pHWaterLab$DataValue,
                                    SpCon = SpConWaterLab$DataValue,
                                    ODO = ODOWaterLab$DataValue,
                                    Turbidity = TurbWaterLab$DataValue,
                                    Gage = GageWaterLab$DataValue,
                                    BGA = BGAWaterLab$DataValue,
                                    chla = chlaWaterLab$DataValue,
                                    fDOM = fDOMWaterLab$DataValue)
                                    #Nitrate = NitrateWaterLab$DataValue)
WaterLab4SepGrabSample

MainSt4SepGrabSample <- data.frame(DateTime = EXWTempMainSt$time, 
                                    Site = "LR_MainStreet_BA",
                                    Temp = EXWTempMainSt$DataValue,
                                    pH = pHMainSt$DataValue,
                                    SpCon = SpConMainSt$DataValue,
                                    ODO = ODOMainSt$DataValue,
                                    Turbidity = TurbMainSt$DataValue,
                                    Gage = GageMainSt$DataValue)
MainSt4SepGrabSample

Mendon4SepGrabSample <- data.frame(DateTime = EXWTempMendon$time, 
                              Site = "LR_Mendon_AA",
                              Temp = EXWTempMendon$DataValue,
                              pH = pHMendon$DataValue,
                              SpCon = SpConMendon$DataValue,
                              ODO = ODOMendon$DataValue,
                              Turbidity = TurbMendon$DataValue,
                              Gage = GageMendon$DataValue,
                              BGA = BGAMendon$DataValue,
                              chla = chlaMendon$DataValue,
                              fDOM = fDOMMendon$DataValue)
                              #Nitrate = NitrateMendon$DataValue)
Mendon4SepGrabSample

Logan4Sep<-rbind.fill(Franklin4SepGrabSample, TonyGrove4SepGrabSample, WaterLab4SepGrabSample, MainSt4SepGrabSample, Mendon4SepGrabSample )

Logan4Sep



##### Knowlton Fork ####


##Knowlton Fork Water Temp##
#exo_Temp
EXWTempKnowlton<- GetValues(RBserver, siteCode="iutah:RB_KF_BA", variableCode="iutah:WaterTemp_EXO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
EXWTempKnowlton = subset(EXWTempKnowlton[ which(EXWTempKnowlton$time ==RB_KF_BADateTime),])
EXWTempKnowlton$DataValue[EXWTempKnowlton$DataValue==-9999.00] <- NA
#Turbidity_Temp
TWTempKnowlton<- GetValues(RBserver, siteCode="iutah:RB_KF_BA", variableCode="iutah:WaterTemp_Turb", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TWTempKnowlton = subset(TWTempKnowlton[ which(TWTempKnowlton$time ==RB_KF_BADateTime),])
TWTempKnowlton$DataValue[TWTempKnowlton$DataValue==-9999.00] <- NA


##Knowlton Fork pH##
pHKnowlton<- GetValues(RBserver, siteCode="iutah:RB_KF_BA", variableCode="iutah:pH", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
pHKnowlton = subset(pHKnowlton[ which(pHKnowlton$time ==RB_KF_BADateTime),])
pHKnowlton$DataValue[pHKnowlton$DataValue==-9999.00] <- NA


##Main St Specific Conductivity##
SpConKnowlton<- GetValues(RBserver, siteCode="iutah:RB_KF_BA", variableCode="iutah:SpCond", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
SpConKnowlton = subset(SpConKnowlton[ which(SpConKnowlton$time ==RB_KF_BADateTime),])
SpConKnowlton$DataValue[SpConKnowlton$DataValue==-9999.00] <- NA


##Knowlton Dissolved Oxygen##
ODOKnowlton<- GetValues(RBserver, siteCode="iutah:RB_KF_BA", variableCode="iutah:ODO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
ODOKnowlton = subset(ODOKnowlton[ which(ODOKnowlton$time ==RB_KF_BADateTime),])
ODOKnowlton$DataValue[ODOKnowlton$DataValue==-9999.00] <- NA


##Knowlton Fork Specific Turbidity##
TurbKnowlton<- GetValues(RBserver, siteCode="iutah:RB_KF_BA", variableCode="iutah:TurbAvg", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TurbKnowlton = subset(TurbKnowlton[ which(TurbKnowlton$time ==RB_KF_BADateTime),])
TurbKnowlton$DataValue[TurbKnowlton$DataValue==-9999.00] <- NA


##Knowlton Fork Gage##
GageKnowlton<- GetValues(RBserver, siteCode="iutah:RB_KF_BA", variableCode="iutah:Stage", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
GageKnowlton = subset(GageKnowlton[ which(GageKnowlton$time ==RB_KF_BADateTime),])
GageKnowlton$DataValue[GageKnowlton$DataValue==-9999.00] <- NA


##### Above Red Butte Reservoir advanced ####


##Above RB Res Water Temp##
#exo_Temp
EXWTempARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:WaterTemp_EXO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
EXWTempARBR = subset(EXWTempARBR[ which(EXWTempARBR$time ==RB_ARBR_AADateTime),])
EXWTempARBR$DataValue[EXWTempARBR$DataValue==-9999.00] <- NA
#Turbidity_Temp
TWTempARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:WaterTemp_Turb", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TWTempARBR = subset(TWTempARBR[ which(TWTempARBR$time ==RB_ARBR_AADateTime),])
TWTempARBR$DataValue[TWTempARBR$DataValue==-9999.00] <- NA


##Above RB Res pH##
pHARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:pH", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
pHARBR = subset(pHARBR[ which(pHARBR$time ==RB_ARBR_AADateTime),])
pHARBR$DataValue[pHARBR$DataValue==-9999.00] <- NA


##Above RB Res Specific Conductivity##
SpConARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:SpCond", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
SpConARBR = subset(SpConARBR[ which(SpConARBR$time ==RB_ARBR_AADateTime),])
SpConARBR$DataValue[SpConARBR$DataValue==-9999.00] <- NA


##Above RB Res Dissolved Oxygen##
ODOARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:ODO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
ODOARBR = subset(ODOARBR[ which(ODOARBR$time ==RB_ARBR_AADateTime),])
ODOARBR$DataValue[ODOARBR$DataValue==-9999.00] <- NA


##Above RB Res Turbidity##
TurbARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:TurbAvg", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TurbARBR = subset(TurbARBR[ which(TurbARBR$time ==RB_ARBR_AADateTime),])
TurbARBR$DataValue[TurbARBR$DataValue==-9999.00] <- NA


##Above RB Res fDOM##
fDOMARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:fDOM", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
fDOMARBR = subset(fDOMARBR[ which(fDOMARBR$time ==RB_ARBR_AADateTime),])
fDOMARBR$DataValue[fDOMARBR$DataValue==-9999.00] <- NA


##Above Red Butte Res Chla##
chlaARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:chlorophyll", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
chlaARBR = subset(chlaARBR[ which(chlaARBR$time ==RB_ARBR_AADateTime),])
chlaARBR$DataValue[chlaARBR$DataValue==-9999.00] <- NA


##Above RB Res Blue Green Algea (BGA)##
BGAARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:BGA", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
BGAARBR = subset(BGAARBR[ which(BGAARBR$time ==RB_ARBR_AADateTime),])
BGAARBR$DataValue[BGAARBR$DataValue==-9999.00] <- NA


# ##Above RB Res Nitrate##
# NitrateARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_AA", variableCode="iutah:Nitrate-N", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
# NitrateARBR = subset(NitrateARBR[ which(NitrateARBR$time ==RB_ARBR_AADateTime),])
# NitrateARBR$DataValue[NitrateARBR$DataValue==-9999.00] <- NA


## Above Red Butte Res Gage height ##
GageARBR<- GetValues(RBserver, siteCode="iutah:RB_ARBR_USGS", variableCode="iutah:USGSStage", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
GageARBR = subset(GageARBR[ which(GageARBR$time ==RB_ARBR_AADateTime),])
GageARBR$DataValue[GageARBR$DataValue==-9999.00] <- NA


##### Red Butte Gate ####


##Red Butte Gate Water Temperature##
#exo_Temp
EXWTempRBG<- GetValues(RBserver, siteCode="iutah:RB_RBG_BA", variableCode="iutah:WaterTemp_EXO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
EXWTempRBG = subset(EXWTempRBG[which(EXWTempRBG$time == RB_RBG_BADateTime),])
EXWTempRBG$DataValue[EXWTempRBG$DataValue==-9999.00] <- NA #Converts -9999.0 to NA
#Turbidity_Temp
TWTempRBG<- GetValues(RBserver, siteCode="iutah:RB_RBG_BA", variableCode="iutah:WaterTemp_Turb", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TWTempRBG = subset(TWTempRBG[which(TWTempRBG$time == RB_RBG_BADateTime),])
TWTempRBG$DataValue[TWTempRBG$DataValue==-9999.00] <- NA


##Red Butte Gate pH##
pHRBG<- GetValues(RBserver, siteCode="iutah:RB_RBG_BA", variableCode="iutah:pH", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
pHRBG = subset(pHRBG[which(pHRBG$time == RB_RBG_BADateTime),])
pHRBG$DataValue[pHRBG$DataValue==-9999.00] <- NA


##Red Butte Gate Specific Conductivity##
SpConRBG<- GetValues(RBserver, siteCode="iutah:RB_RBG_BA", variableCode="iutah:SpCond", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
SpConRBG = subset(SpConRBG[which(SpConRBG$time == RB_RBG_BADateTime),])
SpConRBG$DataValue[SpConRBG$DataValue==-9999.00] <- NA


##Red Butte Gate Dissolved Oxygen##
ODORBG<- GetValues(RBserver, siteCode="iutah:RB_RBG_BA", variableCode="iutah:ODO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
ODORBG = subset(ODORBG[which(ODORBG$time == RB_RBG_BADateTime),])
ODORBG$DataValue[ODORBG$DataValue==-9999.00] <- NA


##Red Butte Gate Specific Tubidity##
TurbRBG<- GetValues(RBserver, siteCode="iutah:RB_RBG_BA", variableCode="iutah:TurbAvg", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TurbRBG = subset(TurbRBG[which(TurbRBG$time == RB_RBG_BADateTime),])
TurbRBG$DataValue[TurbRBG$DataValue==-9999.00] <- NA


##Red Butte Gate Gage##
GageRBG<- GetValues(RBserver, siteCode="iutah:RB_RBG_BA", variableCode="iutah:Stage", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
GageRBG = subset(GageRBG[which(GageRBG$time == RB_RBG_BADateTime),])
GageRBG$DataValue[GageRBG$DataValue==-9999.00] <- NA


##### Cottams Grove ####


##Cottams Grove Water Temp##
#exo_Temp
EXWTempCGrove<- GetValues(RBserver, siteCode="iutah:RB_CG_BA", variableCode="iutah:WaterTemp_EXO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
EXWTempCGrove= subset(EXWTempCGrove[which(EXWTempCGrove$time == RB_CG_BADateTime),])
EXWTempCGrove$DataValue[EXWTempCGrove$DataValue==-9999.00] <- NA
#Turbidity_Temp
TWTempCGrove<- GetValues(RBserver, siteCode="iutah:RB_CG_BA", variableCode="iutah:WaterTemp_Turb", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TWTempCGrove= subset(TWTempCGrove[which(TWTempCGrove$time == RB_CG_BADateTime),])
TWTempCGrove$DataValue[TWTempCGrove$DataValue==-9999.00] <- NA


##Cottams Grove pH##
pHCGrove<- GetValues(RBserver, siteCode="iutah:RB_CG_BA", variableCode="iutah:pH", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
pHCGrove= subset(pHCGrove[which(pHCGrove$time == RB_CG_BADateTime),])
pHCGrove$DataValue[pHCGrove$DataValue==-9999.00] <- NA


##Cottams Grove Specific Conductivity##
SpConCGrove<- GetValues(RBserver, siteCode="iutah:RB_CG_BA", variableCode="iutah:SpCond", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
SpConCGrove= subset(SpConCGrove[which(SpConCGrove$time == RB_CG_BADateTime),])
SpConCGrove$DataValue[SpConCGrove$DataValue==-9999.00] <- NA


##Cottams Grove Dissolved Oxygen##
ODOCGrove<- GetValues(RBserver, siteCode="iutah:RB_CG_BA", variableCode="iutah:ODO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
ODOCGrove= subset(ODOCGrove[which(ODOCGrove$time == RB_CG_BADateTime),])
ODOCGrove$DataValue[ODOCGrove$DataValue==-9999.00] <- NA


##Cottams Grove Specific Turbidity##
TurbCGrove<- GetValues(RBserver, siteCode="iutah:RB_CG_BA", variableCode="iutah:TurbAvg", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TurbCGrove= subset(TurbCGrove[which(TurbCGrove$time == RB_CG_BADateTime),])
TurbCGrove$DataValue[TurbCGrove$DataValue==-9999.00] <- NA


##Cottam Grove Gage height##
GageCGrove<- GetValues(RBserver, siteCode="iutah:RB_CG_BA", variableCode="iutah:Stage", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
GageCGrove= subset(GageCGrove[which(GageCGrove$time == RB_CG_BADateTime),])
GageCGrove$DataValue[GageCGrove$DataValue==-9999.00] <- NA


##### Foothill Drive advanced ####

##Foothill Drive Water Temp##
#exo_Temp
EXWTempFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:WaterTemp_EXO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
EXWTempFoothill= subset(EXWTempFoothill[which(EXWTempFoothill$time == RB_FD_AADateTime),])
EXWTempFoothill$DataValue[EXWTempFoothill$DataValue==-9999.00] <- NA
#Turbidity_Temp
TWTempFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:WaterTemp_Turb", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TWTempFoothill= subset(TWTempFoothill[which(TWTempFoothill$time == RB_FD_AADateTime),])
TWTempFoothill$DataValue[TWTempFoothill$DataValue==-9999.00] <- NA


##Foothill Drive pH##
pHFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:pH", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
pHFoothill= subset(pHFoothill[which(pHFoothill$time == RB_FD_AADateTime),])
pHFoothill$DataValue[pHFoothill$DataValue==-9999.00] <- NA


##Foothill Drive Specific Conductivity##
SpConFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:SpCond", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
SpConFoothill= subset(SpConFoothill[which(SpConFoothill$time == RB_FD_AADateTime),])
SpConFoothill$DataValue[SpConFoothill$DataValue==-9999.00] <- NA


##Foothill Drive Dissolved Oxygen##
ODOFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:ODO", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
ODOFoothill= subset(ODOFoothill[which(ODOFoothill$time == RB_FD_AADateTime),])
ODOFoothill$DataValue[ODOFoothill$DataValue==-9999.00] <- NA


##Foothill Drive Specific Turbidity##
TurbFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:TurbAvg", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
TurbFoothill= subset(TurbFoothill[which(TurbFoothill$time == RB_FD_AADateTime),])
TurbFoothill$DataValue[TurbFoothill$DataValue==-9999.00] <- NA

##Foothill Drive fDOM##
fDOMFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:fDOM", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
fDOMFoothill= subset(fDOMFoothill[which(fDOMFoothill$time == RB_FD_AADateTime),])
fDOMFoothill$DataValue[fDOMFoothill$DataValue==-9999.00] <- NA


##Foothill Drive Chla##
chlaFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:chlorophyll", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
chlaFoothill= subset(chlaFoothill[which(chlaFoothill$time == RB_FD_AADateTime),])
chlaFoothill$DataValue[chlaFoothill$DataValue==-9999.00] <- NA


##Foothill Drive Blue Green Algae (BGA)##
BGAFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:BGA", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
BGAFoothill= subset(BGAFoothill[which(BGAFoothill$time == RB_FD_AADateTime),])
BGAFoothill$DataValue[BGAFoothill$DataValue==-9999.00] <- NA


# ##Foothill Drive Nitrate##
# NitrateFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:Nitrate-N", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
# NitrateFoothill= subset(NitrateFoothill[which(NitrateFoothill$time == RB_FD_AADateTime),])
# NitrateFoothill$DataValue[NitrateFoothill$DataValue==-9999.00] <- NA


##Foothill Drive Gage height##
GageFoothill<- GetValues(RBserver, siteCode="iutah:RB_FD_AA", variableCode="iutah:Stage", startDate = RBStartDate, endDate = RBEndDate, qcID = "1" )
GageFoothill= subset(GageFoothill[which(GageFoothill$time == RB_FD_AADateTime),])
GageFoothill$DataValue[GageFoothill$DataValue==-9999.00] <- NA


##### Red Butte Spreadsheet #####

Knowlton1SepGrabSample <- data.frame(DateTime = EXWTempKnowlton$time, 
                                      Site = "RB_KF_BA",
                                      Temp = EXWTempKnowlton$DataValue,
                                      pH = pHKnowlton$DataValue,
                                      SpCon = SpConKnowlton$DataValue,
                                      ODO = ODOKnowlton$DataValue,
                                      Turbidity = TurbKnowlton$DataValue,
                                      Gage = GageKnowlton$DataValue)
Knowlton1SepGrabSample

ARBR1SepGrabSample <- data.frame(DateTime = EXWTempARBR$time, 
                                  Site = "RB_ARBR_AA",
                                  Temp = EXWTempARBR$DataValue,
                                  pH = pHARBR$DataValue,
                                  SpCon = SpConARBR$DataValue,
                                  ODO = ODOARBR$DataValue,
                                  Turbidity = TurbARBR$DataValue,
                                  #Gage = GageARBR$DataValue,
                                  BGA = BGAARBR$DataValue,
                                  chla = chlaARBR$DataValue,
                                  fDOM = fDOMARBR$DataValue)
                                  #Nitrate = NitrateARBR$DataValue)
ARBR1SepGrabSample


RBG1SepGrabSample <- data.frame(DateTime = EXWTempRBG$time, 
                                    Site = "RB_RBG_BA",
                                    Temp = EXWTempRBG$DataValue,
                                    pH = pHRBG$DataValue,
                                    SpCon = SpConRBG$DataValue,
                                    ODO = ODORBG$DataValue,
                                    Turbidity = TurbRBG$DataValue,
                                    Gage = GageRBG$DataValue)
RBG1SepGrabSample


CGrove1SepGrabSample <- data.frame(DateTime = EXWTempCGrove$time, 
                                    Site = "RB_CG_BA",
                                    Temp = EXWTempCGrove$DataValue,
                                    pH = pHCGrove$DataValue,
                                    SpCon = SpConCGrove$DataValue,
                                    ODO = ODOCGrove$DataValue,
                                    Turbidity = TurbCGrove$DataValue,
                                    Gage = GageCGrove$DataValue)
CGrove1SepGrabSample

Foothill1SepGrabSample <- data.frame(DateTime = EXWTempFoothill$time, 
                                      Site = "RB_FD_AA",
                                      Temp = EXWTempFoothill$DataValue,
                                      pH = pHFoothill$DataValue,
                                      SpCon = SpConFoothill$DataValue,
                                      ODO = ODOFoothill$DataValue,
                                      Turbidity = TurbFoothill$DataValue,
                                      Gage = GageFoothill$DataValue,
                                      BGA = BGAFoothill$DataValue,
                                      chla = chlaFoothill$DataValue,
                                      fDOM = fDOMFoothill$DataValue)
                                      #Nitrate = NitrateFoothill$DataValue)
Foothill1SepGrabSample

RedButte1Sep<- rbind.fill(Knowlton1SepGrabSample, ARBR1SepGrabSample, RBG1SepGrabSample, CGrove1SepGrabSample, Foothill1SepGrabSample)





##### Soapstone #####


##Soapstone Water Temp
#exo_Temp
EXWTempST<- GetValues(PRserver, siteCode="iutah:PR_ST_BA", variableCode="iutah:WaterTemp_EXO", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
EXWTempST= subset(EXWTempST[which(EXWTempST$time == PR_ST_BADateTime),])
EXWTempST$DataValue[EXWTempST$DataValue==-9999.00] <- NA
#Turbidity_Temp
TWTempST<- GetValues(PRserver, siteCode="iutah:PR_ST_BA", variableCode="iutah:WaterTemp_Turb", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
TWTempST= subset(TWTempST[which(TWTempST$time == PR_ST_BADateTime),])
TWTempST$DataValue[TWTempST$DataValue==-9999.00] <- NA


##Soapstone pH##
pHST<- GetValues(PRserver, siteCode="iutah:PR_ST_BA", variableCode="iutah:pH", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
pHST= subset(pHST[which(pHST$time == PR_ST_BADateTime),])
pHST$DataValue[pHST$DataValue==-9999.00] <- NA


##Soapstone Specific Conductivity##
SpConST<- GetValues(PRserver, siteCode="iutah:PR_ST_BA", variableCode="iutah:SpCond", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
SpConST= subset(SpConST[which(SpConST$time == PR_ST_BADateTime),])
SpConST$DataValue[SpConST$DataValue==-9999.00] <- NA


##Soapstone Dissolved Oxygen##
ODOST<- GetValues(PRserver, siteCode="iutah:PR_ST_BA", variableCode="iutah:ODO", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
ODOST= subset(ODOST[which(ODOST$time == PR_ST_BADateTime),])
ODOST$DataValue[ODOST$DataValue==-9999.00] <- NA


##Soapstone Specific Turbidity##
TurbST<- GetValues(PRserver, siteCode="iutah:PR_ST_BA", variableCode="iutah:TurbAvg", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
TurbST= subset(TurbST[which(TurbST$time == PR_ST_BADateTime),])
TurbST$DataValue[TurbST$DataValue==-9999.00] <- NA


##Soapstone Stage##
StageST<- GetValues(PRserver, siteCode="iutah:PR_ST_BA", variableCode="iutah:Stage", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
StageST= subset(StageST[which(StageST$time == PR_ST_BADateTime),])
StageST$DataValue[StageST$DataValue==-9999.00] <- NA


##### Below Jordanelle advanced #########


##Below Jordanelle Temp
#exo_Temp
EXWTempBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:WaterTemp_EXO", startDate = PRStartDate, endDate = PREndDate, methodID= "99", qcID = "1" )
EXWTempBJ= subset(EXWTempBJ[which(EXWTempBJ$time == PR_BJ_AADateTime),])
EXWTempBJ$DataValue[EXWTempBJ$DataValue==-9999.00] <- NA
#Turbidity_Temp
TWTempBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:WaterTemp_Turb", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
TWTempBJ= subset(TWTempBJ[which(TWTempBJ$time == PR_BJ_AADateTime),])
TWTempBJ$DataValue[TWTempBJ$DataValue==-9999.00] <- NA


## Below Jordanelle pH ##
pHBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:pH", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
pHBJ= subset(pHBJ[which(pHBJ$time == PR_BJ_AADateTime),])
pHBJ$DataValue[pHBJ$DataValue==-9999.00] <- NA


##Below Jordanelle Specific Conductivity##
SpConBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:SpCond", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
SpConBJ= subset(SpConBJ[which(SpConBJ$time == PR_BJ_AADateTime),])
SpConBJ$DataValue[SpConBJ$DataValue==-9999.00] <- NA


##Below Jordanelle Dissolved Oxygen##
ODOBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:ODO", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
ODOBJ= subset(ODOBJ[which(ODOBJ$time == PR_BJ_AADateTime),])


##Below Jordanelle Turbidity##
TurbBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:TurbAvg", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
TurbBJ= subset(TurbBJ[which(TurbBJ$time == PR_BJ_AADateTime),])
TurbBJ$DataValue[TurbBJ$DataValue==-9999.00] <- NA


##Below Jordanelle fDOM##
fDOMBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:fDOM", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
fDOMBJ= subset(fDOMBJ[which(fDOMBJ$time == PR_BJ_AADateTime),])
fDOMBJ$DataValue[fDOMBJ$DataValue==-9999.00] <- NA


##Below Jordanelle Chla##
chlaBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:chlorophyll", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
chlaBJ= subset(chlaBJ[which(chlaBJ$time == PR_BJ_AADateTime),])
chlaBJ$DataValue[chlaBJ$DataValue==-9999.00] <- NA


##Below Jordanelle Blue Green Algea (BGA)##
BGABJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:BGA", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
BGABJ= subset(BGABJ[which(BGABJ$time == PR_BJ_AADateTime),])
BGABJ$DataValue[BGABJ$DataValue==-9999.00] <- NA


# ##Below Jordanelle Nitrate##
# NitrateBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_AA", variableCode="iutah:Nitrate-N", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
# NitrateBJ= subset(NitrateBJ[which(NitrateBJ$time == PR_BJ_AADateTime),])
# NitrateBJ$DataValue[NitrateBJ$DataValue==-9999.00] <- NA


##Below Jordanelle Discharge (Q)##
QBJ<- GetValues(PRserver, siteCode="iutah:PR_BJ_CUWCD", variableCode="iutah:CUWCDDischarge", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
QBJ= subset(QBJ[which(QBJ$time == PR_BJ_AADateTime),])
QBJ$DataValue[QBJ$DataValue==-9999.00] <- NA


##### Lower Midway #######

##Lower Midway Water Temp
#exo_Temp
EXWTempLM<- GetValues(PRserver, siteCode="iutah:PR_LM_BA", variableCode="iutah:WaterTemp_EXO", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
EXWTempLM= subset(EXWTempLM[which(EXWTempLM$time == PR_LM_BADateTime),])
EXWTempLM$DataValue[EXWTempLM$DataValue==-9999.00] <- NA #Converts -9999.0 to NA
#Turbidity_Temp
TWTempLM<- GetValues(PRserver, siteCode="iutah:PR_LM_BA", variableCode="iutah:WaterTemp_Turb", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
TWTempLM= subset(TWTempLM[which(TWTempLM$time == PR_LM_BADateTime),])
TWTempLM$DataValue[TWTempLM$DataValue==-9999.00] <- NA


##Lower Midway pH##
pHLM<- GetValues(PRserver, siteCode="iutah:PR_LM_BA", variableCode="iutah:pH", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
pHLM= subset(pHLM[which(pHLM$time == PR_LM_BADateTime),])
pHLM$DataValue[pHLM$DataValue==-9999.00] <- NA


##Lower Midway Specific Conductivity##
SpConLM<- GetValues(PRserver, siteCode="iutah:PR_LM_BA", variableCode="iutah:SpCond", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
SpConLM= subset(SpConLM[which(SpConLM$time == PR_LM_BADateTime),])
SpConLM$DataValue[SpConLM$DataValue==-9999.00] <- NA


##Lower Midway Dissolved Oxygen##
ODOLM<- GetValues(PRserver, siteCode="iutah:PR_LM_BA", variableCode="iutah:ODO", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
ODOLM= subset(ODOLM[which(ODOLM$time == PR_LM_BADateTime),])
ODOLM$DataValue[ODOLM$DataValue==-9999.00] <- NA


##Lower Midway Specific Tubidity##
TurbLM<- GetValues(PRserver, siteCode="iutah:PR_LM_BA", variableCode="iutah:TurbAvg", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
TurbLM= subset(TurbLM[which(TurbLM$time == PR_LM_BADateTime),])
TurbLM$DataValue[TurbLM$DataValue==-9999.00] <- NA


##Lower Midway Discharge (Q)##
QLM<- GetValues(PRserver, siteCode="iutah:PR_uM_CUWCD", variableCode="iutah:CUWCDDischarge", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
QLM= subset(QLM[which(QLM$time == PR_LM_BADateTime),])
QLM$DataValue[QLM$DataValue==-9999.00] <- NA


##### Charleston advanced ######

## Charleston Water Temp
#exo_Temp
EXWTempCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:WaterTemp_EXO", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
EXWTempCH= subset(EXWTempCH[which(EXWTempCH$time == PR_CH_AADateTime),])
EXWTempCH$DataValue[EXWTempCH$DataValue==-9999.00] <- NA
#Turbidity_Temp
TWTempCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:WaterTemp_Turb", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
TWTempCH= subset(TWTempCH[which(TWTempCH$time == PR_CH_AADateTime),])
TWTempCH$DataValue[TWTempCH$DataValue==-9999.00] <- NA


##Charleston pH##
pHCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:pH", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
pHCH= subset(pHCH[which(pHCH$time == PR_CH_AADateTime),])
pHCH$DataValue[pHCH$DataValue==-9999.00] <- NA


##Charleston Specific Conductivity##
SpConCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:SpCond", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
SpConCH= subset(SpConCH[which(SpConCH$time == PR_CH_AADateTime),])
SpConCH$DataValue[SpConCH$DataValue==-9999.00] <- NA


##Charleston Dissolved Oxygen##
ODOCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:ODO", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
ODOCH= subset(ODOCH[which(ODOCH$time == PR_CH_AADateTime),])
ODOCH$DataValue[ODOCH$DataValue==-9999.00] <- NA


##Charleston Specific Turbidity##
TurbCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:TurbAvg", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
TurbCH= subset(TurbCH[which(TurbCH$time == PR_CH_AADateTime),])
TurbCH$DataValue[TurbCH$DataValue==-9999.00] <- NA


##Charleston fDOM##
fDOMCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:fDOM", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
fDOMCH= subset(fDOMCH[which(fDOMCH$time == PR_CH_AADateTime),])
fDOMCH$DataValue[fDOMCH$DataValue==-9999.00] <- NA


##Charleston Chla##
chlaCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:chlorophyll", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
chlaCH= subset(chlaCH[which(chlaCH$time == PR_CH_AADateTime),])
chlaCH$DataValue[chlaCH$DataValue==-9999.00] <- NA


##Charleston Blue Green Algae (BGA)##
BGACH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:BGA", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
BGACH= subset(BGACH[which(BGACH$time == PR_CH_AADateTime),])
BGACH$DataValue[BGACH$DataValue==-9999.00] <- NA


# ##Charleston Nitrate##
# NitrateCH<- GetValues(PRserver, siteCode="iutah:PR_CH_AA", variableCode="iutah:Nitrate-N", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
# NitrateCH= subset(NitrateCH[which(NitrateCH$time == PR_CH_AADateTime),])
# NitrateCH$DataValue[NitrateCH$DataValue==-9999.00] <- NA


##Charleston Discharge (Q)##
QCH<- GetValues(PRserver, siteCode="iutah:PR_CH_CUWCD", variableCode="iutah:CUWCDDischarge", startDate = PRStartDate, endDate = PREndDate, qcID = "1" )
QCH= subset(QCH[which(QCH$time == PR_CH_AADateTime),])
QCH$DataValue[QCH$DataValue==-9999.00] <- NA


##### Provo Spreadsheet #####


Soapstone3SepGrabSample <- data.frame(DateTime = EXWTempST$time, 
                                       Site = "PR_ST_BA",
                                       Temp = EXWTempST$DataValue,
                                       pH = pHST$DataValue,
                                       SpCon = SpConST$DataValue,
                                       ODO = ODOST$DataValue,
                                       Turbidity = TurbST$DataValue,
                                       Gage = StageST$DataValue)
Soapstone3SepGrabSample



BelowJordanelle3SepGrabSample <- data.frame(DateTime = EXWTempBJ$time, 
                                             Site = "PR_BJ_AA",
                                             Temp = EXWTempBJ$DataValue,
                                             pH = pHBJ$DataValue,
                                             SpCon = SpConBJ$DataValue,
                                             ODO = ODOBJ$DataValue,
                                             Turbidity = TurbBJ$DataValue,
                                             Gage = QBJ$DataValue,
                                             BGA = BGABJ$DataValue,
                                             chla = chlaBJ$DataValue,
                                             fDOM = fDOMBJ$DataValue)
                                            # Nitrate = NitrateBJ$DataValue)
BelowJordanelle3SepGrabSample

LowerMidway3SepGrabSample <- data.frame(DateTime = EXWTempLM$time, 
                                         Site = "PR_LM_BA",
                                         Temp = EXWTempLM$DataValue,
                                         pH = pHLM$DataValue,
                                         SpCon = SpConLM$DataValue,
                                         ODO = ODOLM$DataValue,
                                         Turbidity = TurbLM$DataValue,
                                         Gage = QLM$DataValue)
LowerMidway3SepGrabSample

Charleston3SepGrabSample <- data.frame(DateTime = EXWTempCH$time, 
                                        Site = "PR_CH_AA",
                                        Temp = EXWTempCH$DataValue,
                                        pH = pHCH$DataValue,
                                        SpCon = SpConCH$DataValue,
                                        ODO = ODOCH$DataValue,
                                        Turbidity = TurbCH$DataValue,
                                        Gage = QCH$DataValue,
                                        BGA = BGACH$DataValue,
                                        chla = chlaCH$DataValue,
                                        fDOM = fDOMCH$DataValue)
                                        #Nitrate = NitrateCH$DataValue)
Charleston3SepGrabSample

Provo3Sep <-rbind.fill(Soapstone3SepGrabSample, BelowJordanelle3SepGrabSample, LowerMidway3SepGrabSample, Charleston3SepGrabSample)


##### All combine and write ####

GrabSamples4Sep <- rbind.fill(RedButte1Sep, Logan4Sep, Provo3Sep)

write.csv(GrabSamples4Sep, file = "GrabSamples" )





