
I. Identity Variables
=====================
	Data in tidyData are aggregated according to two identity variables "subject.id"
	and "activity". There is then one and only one observation for each combination
	of "subject.id" + "activity". This is also why we count a total of 180 (6x30) rows
	in the dataset.

	"subject.id" an integer ranging from 1 to 30 (the observed population counts 30 subjects)
	"activity"	 a factor variable taking as values 
					   "walking"
					   "walking.upstairs"
					   "walking.downstairs"
					   "sitting"
					   "standing"
					   "laying"

II. Observation variables
=========================

The observation variables are derived from the so-called "features" of the source data.
The current section will refer to those features, but the reader who would like to get
a better understanding of what they are and how they are computed should pay a visit to
the web site :
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
and/or consult the following papers:
	https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-122.pdf
	http://www.icephd.org/sites/default/files/IWAAL2012.pdf
	https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf


Names:
	
	The observation variables have their names composed of different elements which
	are separated by a dot "."
	
	The naming elements are:
	
		<domain>      : ["time" | "frequency"]
				relates to observations made either in the time domain
				or in the frequency domain (resulting from the Fourier transform
				of the raw temporal data)
				
		<referential> : ["body" | "gravity"]
				referential data are obtained by applying a numeric filtering
				on the raw data. This allows to discern between the effect of
				the earth gravity and the true motion of the body. 
		
		<sensor>      : ["acc" | "gyro"]
				the smart phone is provided with two types of sensors.
				The accelerometer which captures variations of movement along a specific
				axis.
				The gyroscope which relates to the rotational movement around a specific
				axis.
				
		<axis>        : [ "x" | "y" | "z"]
				"x" and "y" forming the horizontal plane, "z" being the vertical axis
				of the device.
		
		<statistics>  : ["mean" | "std"]
				we are only interested in the mean or the standard deviation of the
				observed data. <statistics> allow to distinguish between those two
				consolidated data.
		
        magnitude
				a magnitude variable is calculated from the three-dimensional (x,y,z)
				signals using the Euclidean norm. There is then no "axis" for a magnitude
				variable.
		
		jerk
				the body linear acceleration and angular velocity were derived in time
				to obtain Jerk signals which describes the changes of accelerations.
				Jerk is thus a measure of how fast the magnitude of the acceleration changes.
				
	Values
		Values are normalized and bounded within [-1,1].


II.1 Observation variables, Group I
-----------------------------------

	Naming pattern :
		<domain>.<referential>.<sensor>.<axis>.<statistics>
	or	<domain>.<referential>.<sensor>.magnitude.<statistics>
		
	Name list:
		"time.body.acc.x.mean"                         "time.body.acc.y.mean"                        
		"time.body.acc.z.mean"                         "time.body.acc.x.std"                         
		"time.body.acc.y.std"                          "time.body.acc.z.std"                         
		"time.gravity.acc.x.mean"                      "time.gravity.acc.y.mean"                     
		"time.gravity.acc.z.mean"                      "time.gravity.acc.x.std"                      
		"time.gravity.acc.y.std"                       "time.gravity.acc.z.std"   
		"time.body.gyro.x.mean"                        "time.body.gyro.y.mean"                       
		"time.body.gyro.z.mean"                        "time.body.gyro.x.std"                        
		"time.body.gyro.y.std"                         "time.body.gyro.z.std"
		"frequency.body.acc.x.mean"                    "frequency.body.acc.y.mean"                   
		"frequency.body.acc.z.mean"                    "frequency.body.acc.x.std"                    
		"frequency.body.acc.y.std"                     "frequency.body.acc.z.std"
		"frequency.body.gyro.x.mean"                   "frequency.body.gyro.y.mean"                  
		"frequency.body.gyro.z.mean"                   "frequency.body.gyro.x.std"                   
		"frequency.body.gyro.y.std"                    "frequency.body.gyro.z.std" 

		"time.body.acc.magnitude.mean"                 "time.body.acc.magnitude.std"                 
		"time.gravity.acc.magnitude.mean"              "time.gravity.acc.magnitude.std"    
		"frequency.body.acc.magnitude.mean"            "frequency.body.acc.magnitude.std" 
		"time.body.gyro.magnitude.mean"                "time.body.gyro.magnitude.std" 	

II.2 Observation variables, Group II, Jerk signals
--------------------------------------------------
	Naming pattern:
		<domain>.<referential>.<sensor>.jerk.<axis>.<statistics>
	or	<domain>.<referential>.<sensor>.jerk.magnitude.<statistics>
		
	Name list:
		"frequency.body.acc.jerk.x.mean"               "frequency.body.acc.jerk.y.mean"              
		"frequency.body.acc.jerk.z.mean"               "frequency.body.acc.jerk.x.std"               
		"frequency.body.acc.jerk.y.std"                "frequency.body.acc.jerk.z.std"  
		"time.body.acc.jerk.x.mean"                    "time.body.acc.jerk.y.mean"                   
		"time.body.acc.jerk.z.mean"                    "time.body.acc.jerk.x.std"                    
		"time.body.acc.jerk.y.std"                     "time.body.acc.jerk.z.std"      
		"time.body.gyro.jerk.x.mean"                   "time.body.gyro.jerk.y.mean"                  
		"time.body.gyro.jerk.z.mean"                   "time.body.gyro.jerk.x.std"                   
		"time.body.gyro.jerk.y.std"                    "time.body.gyro.jerk.z.std"               
		"time.body.gyro.jerk.magnitude.mean"           "time.body.gyro.jerk.magnitude.std" 
		"time.body.acc.jerk.magnitude.mean"            "time.body.acc.jerk.magnitude.std"

II.3 Observation variables, Group III
-------------------------------------
	Group III groups frequency variables with a double body domain computation.
	
	Naming list:
		"frequency.body.body.acc.jerk.magnitude.mean"  "frequency.body.body.acc.jerk.magnitude.std"  
		"frequency.body.body.gyro.magnitude.mean"      "frequency.body.body.gyro.magnitude.std"      
		"frequency.body.body.gyro.jerk.magnitude.mean" "frequency.body.body.gyro.jerk.magnitude.std"
		
III. License
============
Use of this dataset in publications must be acknowledged by referencing the following publication
	Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
	Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
	International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors
or their institutions for its use or misuse. Any commercial use is prohibited.
	Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
