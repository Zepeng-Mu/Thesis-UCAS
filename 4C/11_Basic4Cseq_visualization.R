library(Basic4Cseq)

#### Viewpoint1 ####
load(file = "~/Documents/study/biology/labs/ZengLab/thesis/data/vp1_180327_2")
poiDf1 = read.csv(file = "~/Documents/study/biology/labs/ZengLab/thesis/data/4C_poi_df.csv",
                 header = T,
                 stringsAsFactors = F)

visualizeViewpoint(viewpoint1,
                   poi = poiDf1,
                   plotFileName = "~/Documents/study/biology/labs/ZengLab/thesis/结果/图/VP1_near_cis.pdf",
                   windowLength = 5,
                   interpolationType = "median",
                   picDim = c(10, 4),
                   maxY = 600,
                   plotTitle = "Near-Cis Visualization of VP1",
                   loessSpan = 0.1,
                   # xAxisIntervalLength = 30000,
                   yAxisIntervalLength = 100,
                   useFragEnds = T)

drawHeatmap(viewpoint1,
            plotFileName = "~/Documents/study/biology/labs/ZengLab/thesis/结果/图/VP1_heatmap.pdf",
            smoothingType = "median",
            picDim = c(10, 3),
            band = 50)

readsVP1 = as.data.frame(viewpoint1@rawFragments)
readsVP1 = readsVP1[order(readsVP1$fragEndReadsAverage, decreasing = T), ]

#### viewpoint2 #### 
load(file = "~/Documents/study/biology/labs/ZengLab/thesis/data/vp2_180327")
poiDf2 = read.csv(file = "~/Documents/study/biology/labs/ZengLab/thesis/data/4C_poi_df_v2.csv",
                 header = T,
                 stringsAsFactors = F)

visualizeViewpoint(viewpoint2,
                   poi = poiDf2,
                   plotFileName = "~/Documents/study/biology/labs/ZengLab/thesis/结果/图/VP2_near_cis.pdf",
                   windowLength = 5,
                   interpolationType = "median",
                   picDim = c(10, 4),
                   maxY = 150,
                   plotTitle = "Near-Cis Visualization of VP2",
                   loessSpan = 0.1,
                   # xAxisIntervalLength = 30000,
                   yAxisIntervalLength = 50,
                   useFragEnds = T)

drawHeatmap(viewpoint2,
            plotFileName = "~/Documents/study/biology/labs/ZengLab/thesis/结果/图/VP2_heatmap.pdf",
            smoothingType = "median",
            picDim = c(10, 3),
            band = 50)
