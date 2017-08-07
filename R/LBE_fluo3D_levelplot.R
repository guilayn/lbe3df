#' 3D Fluorescence level plot by plotly, after processing
#'
#' After running LBE_fluo3D_processing() with your options, run this function to visualize and export your surface plot. Results (plots in pdf and/or png and/or interactive html) will be exported to a folder inside your directory called "Output_data".
#' @param x The default value of "x_vector" is assuming that "LBE_fluo3D_processing" have just been used. Otherwise it must be a vector containing the emission wavelenghts range.
#' @param y The default value of "y_vector" is assuming that "LBE_fluo3D_processing" have just been used. Otherwise it must be a vector containing the excitation wavelenghts range.
#' @param z The default value of "xy_vector" is assuming that "LBE_fluo3D_processing" have just been used. Otherwise you must provide a matrix containing the z values (intensity) where X must be the lines, Y must be the columns and Z must be the values of the table.
#' @param plot_zones_polygons Boolean (TRUE or FALSE). It allows you to chose wether you want to plot the polygons with the 7 zones or not.
#' @param export_html Boolean (TRUE or FALSE). It allows you to chose wether you want to export a plotly html interactive file (might generate about 3 MB).
#' @param export_png Boolean (TRUE or FALSE). It allows you to chose wether you want to export a png static plot.
#' @param export_pdf Boolean (TRUE or FALSE). It allows you to chose wether you want to export a png static plot.
#' @param n_color Number of colors that will be picked up in the color palette to build the color scale. Normally it is relevant only for color scales containing several colors.
#' @param color_palette 1 to 6. Default is 1 for "viridis" (optimized for all types color blindness and with no loss of information for black and white printing). Use 2 for "gray.colors" if you want directly a black and white plot. You can select other interesting color scales such magma (3), plasma (4), inferno (5), terrain.colors (6),topo.colors (7) and cm.colors (8).
#' @param directory Default is the working directory. Better not change it.
#' @param sample_name_ Default is the output from processing function. Better not change it.
#' @keywords 3D fluorescence
#' @export
#' @examples
#' > setwd(XXXX) #XXX is your directory contaning the .sp files (copy and paste from the brownse and replace all the "\" by "/").
#' > LBE_fluo3D_processing() #include your options if you want.
#' > LBE_fluo3D_levelplot(color_palette="gray.colors") #export pdf and png with a black and white surface plot.

LBE_fluo3D_levelplot=function(x=x_vector, #assuming that "LBE_fluo3D_processing" have just been used
                              y=y_vector,  #assuming that "LBE_fluo3D_processing" have just been used
                              z=xy_vector,  #assuming that "LBE_fluo3D_processing" have just been used
                              plot_zones_polygons=TRUE,
                              export_html=FALSE,
                              export_png=TRUE,
                              export_pdf=TRUE,
                              n_color=10,
                              color_palette=1,
                              directory=directory_processing,
                              sample_name_=sample_name) {
  warning(paste0("You should run ","LBE_fluo3D_processing ","function in your data before using this function."))
  #print(1)
  print("Setting directories")
  wd_out=paste0(directory,"/Output_data")
  dir.create(wd_out)

  #### 1.2 Definition of 3DF' zones ####
  #### 1.2.1 3DF Zone, polygons coordinates ####
  print("Defining polygons")
  if (plot_zones_polygons) {
    polygon1=data.frame(id="I",
                        x=c(200,325,325,275,200),
                        y=c(200,200,260,260,200))
    polygon2=data.frame(id="II",
                        x=c(325,390,390,325,325),
                        y=c(200,200,260,260,200))
    polygon3=data.frame(id="III",
                        x=c(275,390,390,325,275),
                        y=c(260,260,310,310,260))
    polygon4=data.frame(id="IV",
                        x=c(390,490,390,390),
                        y=c(200,260,260,200))
    polygon5=data.frame(id="V",
                        x=c(390,490,600,390,390),
                        y=c(260,260,310,310,260))
    polygon6=data.frame(id="VI",
                        x=c(325,600,600,400,325),
                        y=c(310,310,380,380,310))
    polygon7=data.frame(id="VII",
                        x=c(400,600,600,400),
                        y=c(380,380,590,380))
    list_polygons=rbind(polygon1,polygon2,polygon3,polygon4,polygon5,polygon6,polygon7)

    #### 1.2.2 3DF Zones, text coordinates ####
    text_zone1=data.frame(id="I",
                          x=300,
                          y=230)
    text_zone2=data.frame(id="II",
                          x=(390-325)/2+325,
                          y=230)
    text_zone3=data.frame(id="III",
                          x=(390-325)/2+325,
                          y=(310-260)/2+260)
    text_zone4=data.frame(id="IV",
                          x=410,
                          y=230)
    text_zone5=data.frame(id="V",
                          x=420,
                          y=(310-260)/2+260)
    text_zone6=data.frame(id="VI",
                          x=435,
                          y=(380-310)/2+310)
    text_zone7=data.frame(id="VII",
                          x=500,
                          y=425)
    list_text_zones=rbind(text_zone1,text_zone2,text_zone3,text_zone4,text_zone5,text_zone6,text_zone7)
  } else {
    list_polygons=data.frame(id="",x=c(201,201),y=c(201,201))
    list_text_zones=data.frame(id="",x=350,y=350)
  }

print("Working on plots")
  n_color=n_color
list_colorfunction=list(viridis,gray.colors,magma,plasma,inferno,terrain.colors,topo.colors,cm.colors)
colorfunction=list_colorfunction[[color_palette]]
#print(4)
  print(plot_ly(x=as.numeric(x),
                y=as.numeric(y),
                z=t(as.matrix(z)),
                type="contour",
                #coloring="heatmap",
                colorscale = data.frame(seq(0,1,length.out=n_color),colorfunction(n_color))) %>%  #instead of viridis, other pallete can be used such as magma, plasma, inferno
          layout(                        # all of layout's properties: /r/reference/#layout
            title = "3D fluorescence spectrum", # layout's title: /r/reference/#layout-title
            xaxis = list(           # layout's xaxis is a named list. List of valid keys: /r/reference/#layout-xaxis
              title = "Emission",      # xaxis's title: /r/reference/#layout-xaxis-title
              showgrid = T),       # xaxis's showgrid: /r/reference/#layout-xaxis-showgrid
            yaxis = list(           # layout's yaxis is a named list. List of valid keys: /r/reference/#layout-yaxis
              title = "Excitation")) %>%  # yaxis's title: /r/reference/#layout-yaxis-title
          add_polygons(z=NULL,
                       colorscale=NULL,
                       x=list_polygons$x,
                       y=list_polygons$y,
                       split=list_polygons$id,
                       line=list(color="black",width=2),
                       opacity=1,
                       fillcolor='rgba(7, 164, 181, 0)',  ##only way to keep lines black with no fill was to set a color with tgis rgba funtion with 4th digit of 0
                       showlegend=T) %>%
          add_annotations(z=NULL,
                          colorscale=NULL,
                          x=list_text_zones$x,
                          y=list_text_zones$y,
                          text=list_text_zones$id,
                          split=list_text_zones$id,
                          showlegend=F,
                          showarrow=F,
                          font=list(color="white",size=20)))

  print("Exporting plots")

  if (export_html) {
    htmlwidgets::saveWidget(as_widget(last_plot()), paste0(wd_out,"/",sample_name_,"_contour_plot.html"))}

  if (export_pdf){
  plotly_exp_directory_pdf=paste0(wd_out,"/",sample_name_,"_contour_plot.pdf")
  export(p=last_plot(),file=plotly_exp_directory_pdf)
  }

  if (export_png){
  plotly_exp_directory_png=paste0(wd_out,"/",sample_name_,"_contour_plot.png")
  export(p=last_plot(),file=plotly_exp_directory_png)
  }
} #end of the function