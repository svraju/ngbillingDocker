/*
 jBilling - The Enterprise Open Source Billing System
 Copyright (C) 2003-2011 Enterprise jBilling Software Ltd. and Emiliano Conde

 This file is part of jbilling.

 jbilling is free software: you can redistribute it and/or modify
 it under the terms of the GNU Affero General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 jbilling is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Affero General Public License for more details.

 You should have received a copy of the GNU Affero General Public License
 along with jbilling.  If not, see <http://www.gnu.org/licenses/>.

 This source was modified by Web Data Technologies LLP (www.webdatatechnologies.in) since 15 Nov 2015.
You may download the latest source from webdataconsulting.github.io.

 */

includeTargets << grailsScript("Init")
includeTargets << new File("${basedir}/scripts/Liquibase.groovy")

target(rollbackDb: "Upgrades database to the latest version") {
    depends(parseArguments, initLiquibase)

    def version = getApplicationMinorVersion(argsMap)
    def tag = argsMap.tag

    if (!tag) throw new IllegalArgumentException("Argument -tag=[tag name] is required for tag / rollback operations!");

    println "Rolling back database to tag '${tag}'"
    echoDatabaseArgs()


    // liquibase upgrade changelog
    def changelog = "./descriptors/database/jbilling-upgrade-${version}.xml"

    ant.rollbackDatabase(liquibaseTaskAttrs(changeLogFile: changelog, rollbackTag: tag))
}

setDefaultTarget(rollbackDb)
