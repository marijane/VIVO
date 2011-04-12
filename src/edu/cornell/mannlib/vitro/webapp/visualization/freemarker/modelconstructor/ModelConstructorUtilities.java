/* $This file is distributed under the terms of the license in /doc/license.txt$ */
package edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor;

import java.util.HashMap;
import java.util.Map;

import com.hp.hpl.jena.query.Dataset;
import com.hp.hpl.jena.rdf.model.Model;

import edu.cornell.mannlib.vitro.webapp.visualization.exceptions.MalformedQueryParametersException;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.ModelFactoryInterface;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.OrganizationAssociatedPeopleModelWithTypesFactory;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.OrganizationModelWithTypesFactory;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.OrganizationToGrantsForSubOrganizationsFactory;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.OrganizationToPublicationsForSubOrganizationsFactory;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.PeopleToGrantsFactory;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.PeopleToPublicationsFactory;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.PersonToGrantsFactory;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.PersonToPublicationsFactory;
import edu.cornell.mannlib.vitro.webapp.visualization.freemarker.modelconstructor.factory.SubOrganizationWithinModelFactory;

public class ModelConstructorUtilities {
	
	@SuppressWarnings("serial")
	private static final Map<String, ModelFactoryInterface> modelTypeIdentifierToFactory = new HashMap<String, ModelFactoryInterface>() {{
		put(PersonToPublicationsModelConstructor.MODEL_TYPE, new PersonToPublicationsFactory());
		put(PeopleToPublicationsModelConstructor.MODEL_TYPE, new PeopleToPublicationsFactory());
		put(PersonToGrantsModelConstructor.MODEL_TYPE, new PersonToGrantsFactory());
		put(PeopleToGrantsModelConstructor.MODEL_TYPE, new PeopleToGrantsFactory());
		put(OrganizationToPublicationsForSubOrganizationsModelConstructor.MODEL_TYPE, new OrganizationToPublicationsForSubOrganizationsFactory());
		put(OrganizationToGrantsForSubOrganizationsModelConstructor.MODEL_TYPE, new OrganizationToGrantsForSubOrganizationsFactory());
		put(OrganizationAssociatedPeopleModelWithTypesConstructor.MODEL_TYPE, new OrganizationAssociatedPeopleModelWithTypesFactory());
		put(OrganizationModelWithTypesConstructor.MODEL_TYPE, new OrganizationModelWithTypesFactory());
		put(SubOrganizationWithinModelConstructor.MODEL_TYPE, new SubOrganizationWithinModelFactory());
	}};
	
	public static Model getOrConstructModel(String uri, String modelType, Dataset dataset) 
				throws MalformedQueryParametersException {
		return modelTypeIdentifierToFactory.get(modelType).getOrCreateModel(uri, dataset);
	}
}